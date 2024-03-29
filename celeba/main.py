# -*- coding: utf-8 -*-
"""
Created on Fri Mar 22 14:24:17 2024

@author: 602-24
"""

import os
import tkinter as tk
import tkinter.filedialog as fd
import tkinter.scrolledtext as st
from tkinter import Menu
from tkinter import messagebox
from tkinter import colorchooser
import cv2
import numpy as np
from PIL import Image
from PIL import ImageTk
from tensorflow.keras.models import load_model


image = None
image_origin = None
filename = ""
vid = None
is_saved = True
paused = False
model = None

scale = 1

rect_color = (0, 255, 0)

text_color = (255, 255, 0)
font_size = 0.3

selected_categories = []

image_w = 64
image_h = 64


def MyLog(msg):
    # scrolled text print...
    textLog.insert(tk.INSERT, msg + "\r\n")
    textLog.see("end")
    

def predict_model(model_name, image):
    global model
    
    hdf5_file = "./models/" + model_name + ".hdf5"
    
    if os.path.exists(hdf5_file):
        model = load_model(hdf5_file)
    else:
    	MyLog("Error ! load model")
    	exit()
    
    result = model.predict(image)[0]
    
    return result


def image_print(x):
    global is_saved
    
    img = Image.fromarray(x) # return image object
    
    resized_img = img.resize((int(img.width * scale), int(img.height * scale)), Image.ANTIALIAS)
    # img.save('./data/temp.jpg', dpi=(300,300))
    
    imgTK = ImageTk.PhotoImage(image=resized_img) # tkinter 호환 이미지로 변경

    width = imgTK.width()
    height = imgTK.height()

    image_canvas.config(scrollregion=(0,0,width,height))
    image_canvas.create_image(0,0,anchor="nw",image=imgTK)
    
    image_canvas.image = imgTK # for avoid garbage collector 
    
    is_saved = False


def open_image():
    global image, image_origin
    global filename
    
    filename = fd.askopenfilename(initialdir='./data/',title="select a file",
                                            filetypes =(("jpg files","*.jpg"),
                                                        ("png files","*.png"),("all files","*.*")))
    if(filename == "") :
        MyLog("file name is empty")
        return

    MyLog("open_image: " + filename)
        
    image = cv2.imread(filename)
    
    if image is None:
        MyLog("file load failed")
        return

    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # tkinter 색상체계로 변환 BGR -> RGB
    image_origin = image.copy()

    image_print(image)


def original_image():
    MyLog("original image...")
    image_print(image_origin)
    

def prediction():
    global image
    
    image = image_origin.copy()
    
    # OpenCV의 얼굴 검출을 위한 분류기를 로드합니다.
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

    gray = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)

    # 얼굴 감지
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=4, minSize=(30, 30))

    # 감지된 얼굴 주위에 사각형 그리기
    for (x, y, w, h) in faces:
        # 머리 크기까지 사각형 확장
        x -= int(0.1 * w)
        y -= int(0.1 * h)
        w = int(1.2 * w)
        h = int(1.2 * h)
        
        cv2.rectangle(image, (x, y), (x+w, y+h), rect_color, 2)
        
        # 예측하기
        face_roi = image[y:y+h,x:x+w]
        face_roi = cv2.resize(face_roi, (image_w, image_h))
        # face_roi에 차원 추가
        face_roi = np.expand_dims(face_roi, axis=0)
        
        if selected_categories:
            i = 0
            for category in selected_categories:
                i += int(font_size * 30)
                # 예측 결과 백분율
                result = predict_model(category, face_roi)[0] * 100
                
                if result >= 0:
                    cv2.putText(image, '{} {:.0f}%'.format(category, abs(result)), (x+5, y+i), cv2.FONT_HERSHEY_COMPLEX, font_size, text_color, 1)
            

    MyLog("predict image...")
    image_print(image)


def open_video():
    global filename, vid
    
    filename = fd.askopenfilename(initialdir='./data/video/',title="select a file",
                                            filetypes=(("Video files", "*.mp4;*.avi"),
                                                       ("all files","*.*")))
    if filename:
        vid = None
        update_video()


skip_frames = 5  # 5 프레임마다 얼굴 감지 수행
faces = []
draw_rect = False

def update_video():
    global vid, image, image_origin, faces, gray
    
    if vid is None: # vid 객체가 없으면 동영상을 열어줍니다.
        video_source = filename
        vid = cv2.VideoCapture(video_source)
        # cv2.VideoCapture(0) 0은 내장된 기본캠, 외부 연결 카메라는 1부터 시작
        
        
    if not paused:
        ret, frame = vid.read()
        if ret:
            image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            image_origin = image.copy()
            
            # 매 skip_frames번째 프레임에서만 얼굴 감지 수행
            if draw_rect:
                if vid.get(cv2.CAP_PROP_POS_FRAMES) % skip_frames == 0:
                    # OpenCV의 얼굴 검출을 위한 분류기를 로드합니다.
                    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
        
                    gray = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
                    
                    blur = cv2.GaussianBlur(gray, (5,5), 0)
        
                    # 얼굴 감지
                    faces = []
                    faces = face_cascade.detectMultiScale(blur, scaleFactor=1.1, minNeighbors=3, minSize=(30, 30))
        
                # 감지된 얼굴 주위에 사각형 그리기
                for (x, y, w, h) in faces:
                    # 머리 크기까지 사각형 확장
                    x -= int(0.1 * w)
                    y -= int(0.1 * h)
                    w = int(1.2 * w)
                    h = int(1.2 * h)
                    
                    cv2.rectangle(image, (x, y), (x+w, y+h), rect_color, 2)

            image_print(image)    
        
        else:
           # 동영상이 끝나면 vid 객체를 해제합니다.
           vid.release()
           vid = None
           return
   
    top.after(20, update_video)


def quit_video():
    global vid, filename
    
    vid.release()
    image_canvas.delete("all")

    filename = ""
    vid = None
    
    
def toggle_face_detection():
    global draw_rect
    draw_rect = not draw_rect
    if draw_rect:
        button_face_detection.config(bg="gray")
    else:
        button_face_detection.config(bg="SystemButtonFace")  # 사각형 그리기 비활성화일 때 버튼 색상을 기본으로 변경


def toggle_play_pause():
    global paused
    paused = not paused


def on_canvas_click(event):
    toggle_play_pause()


def update_checkbox_list(name):
    
    if name in selected_categories:
        selected_categories.remove(name)
    else:
        selected_categories.append(name)
    
    # 선택한 카테고리 알파벳 순으로 정렬
    if selected_categories:
        selected_categories.sort()


def update_text_color():
    global text_color
    
    try:
        r = int(entry_r.get())
        g = int(entry_g.get())
        b = int(entry_b.get())
        if 0 <= r <= 255 and 0 <= g <= 255 and 0 <= b <= 255:
            color = "#%02x%02x%02x" % (r, g, b)
            color_choose_button.config(bg=color)
            
            text_color = (r, g, b)

    except ValueError:
        pass


def choose_text_color():
    global text_color
    
    color = colorchooser.askcolor(title="Choose color")
    if color[1]:  # 사용자가 색상을 선택한 경우에만 처리
        selected_color = color[1]
        color_choose_button.config(bg=selected_color)
        
        r, g, b = color[0]
        
        entry_r.delete(0, tk.END)
        entry_r.insert(0, r)
        entry_g.delete(0, tk.END)
        entry_g.insert(0, g)
        entry_b.delete(0, tk.END)
        entry_b.insert(0, b)
        
        text_color = (r, g, b)
        
  
def choose_font_size(event=None):
    global font_size
    
    font_size = scale_font_size.get() / 10
            

def choose_image_scale(event=None):
    global scale
    
    scale = scale_image_scale.get() /10

    image_print(image)





#### 메뉴바
def white_to_transparency(img):
    # 이미지를 RGBA 모드로 변환합니다.
    rgba_img = img.convert('RGBA')
    
    # NumPy 배열로 변환합니다.
    x = np.array(rgba_img)
    
    # 흰색 픽셀을 투명하게 만듭니다.
    x[:, :, 3] = (255 * (x[:, :, :3] <= 200).any(axis=2)).astype(np.uint8)
    
    # NumPy 배열을 Pillow 이미지 객체로 변환하여 반환합니다.
    return Image.fromarray(x)
    

def uniquify(path):
    filename, extension = os.path.splitext(path)
    counter = 1

    while os.path.exists(path):
        path = filename + " (" + str(counter) + ")" + extension
        counter += 1

    return path


def save_file():
    global is_saved

    if filename == "":
        MyLog("No file provided")
        return
    
    img = Image.fromarray(image)
    # 파일 확장자에 따라 저장할 함수를 선택합니다.
    file_extension = os.path.splitext(filename)[1].lower()
    
    if file_extension == '.png':
        # PNG 형식으로 저장합니다.
        if img.mode == 'RGBA':
            wimg = white_to_transparency(img)
            wimg.save(filename)
        else:
            img.save(filename)
    else:
        if img.mode == 'RGBA':
            # RGBA 형식은 다른 형식으로 저장할 수 없습니다. RGB 형식으로 변환하여 저장합니다.
            img = img.convert('RGB')
        img.save(filename)
    
    MyLog("Saved File : " + filename)
    
    is_saved = True


def save_as_file():
    global is_saved
    
    filepath = fd.asksaveasfilename(initialdir='./files/',title="select a file",
                          filetypes =(("png files","*.png"),
                                      ("jpg files","*.jpg"),("all files","*.*")))

    if filepath is None:  # asksaveasfile return `None` if dialog closed with "cancel".
        return
    if filepath == "":
        MyLog("No file name provided")
        return
        
    img = Image.fromarray(image)
    # 파일 확장자에 따라 저장할 함수를 선택합니다.
    file_extension = os.path.splitext(filepath)[1].lower()
    
    if file_extension == '.png':
        # PNG 형식으로 저장합니다.
        if img.mode == 'RGBA':
            wimg = white_to_transparency(img)
            wimg.save(uniquify(filepath))
        else:
            img.save(uniquify(filepath))
    else:
        if img.mode == 'RGBA':
            # RGBA 형식은 다른 형식으로 저장할 수 없습니다. RGB 형식으로 변환하여 저장합니다.
            img = img.convert('RGB')
        img.save(uniquify(filepath))
    
    MyLog("Saved File : " + filepath)
    
    is_saved = True



def close_image() :
    global image, filename, image_origin
    # 파일 저장 여부를 확인하고 사용자에게 메시지를 표시합니다.
    if not is_saved:
        result = messagebox.askyesno("확인", "파일을 저장하지 않았습니다. 그래도 종료하시겠습니까?")
        if not result:
            return  # 종료를 취소합니다.
        
    image = None
    filename = ""
    image_origin = None
    image_canvas.config(scrollregion=(0, 0, 0, 0))
    image_canvas.image = None
    
    MyLog("close image")
    

def about():
    messagebox.showinfo('Face prediction Version 0.0', 'This program aims at predicting face')
   
    
def close_window():
    # 파일 저장 여부를 확인하고 사용자에게 메시지를 표시합니다.
    if not is_saved:
        result = messagebox.askyesno("확인", "파일을 저장하지 않았습니다. 그래도 종료하시겠습니까?")
        if not result:
            return  # 종료를 취소합니다.
    cv2.destroyAllWindows()
    top.quit()  # 종료합니다.

        






# Tk 객체 생성
top = tk.Tk()
top.title("face_cascade")
top.geometry("1120x620")
imageWnd_width = 800
imageWnd_height = 600

image_canvas = tk.Canvas(top, relief=tk.SUNKEN)
image_canvas.config(width=imageWnd_width-20, height=imageWnd_height-20)
image_canvas.config(highlightthickness=1)

sbarV = tk.Scrollbar(top, orient=tk.VERTICAL)
sbarH = tk.Scrollbar(top, orient=tk.HORIZONTAL)
sbarV.config(command=image_canvas.yview)
sbarH.config(command=image_canvas.xview)

image_canvas.config(yscrollcommand=sbarV.set)
image_canvas.config(xscrollcommand=sbarH.set)

sbarH.place(x=5, y=imageWnd_height - 20 + 5 + 2, width=imageWnd_width-20, height=20)
sbarV.place(x=imageWnd_width-20 + 5 + 2, y=5, width=20, height=imageWnd_height-20)
image_canvas.place(x=5, y=5, width=imageWnd_width-20, height=imageWnd_height-20)

# 캔버스에 클릭 이벤트 바인딩
image_canvas.bind("<Button-1>", on_canvas_click)



right_x_pos = 5 + imageWnd_width + 5
right_y_pos = 5

button_image_open = tk.Button(top, text="이미지 불러오기", command=open_image, repeatdelay=1000, repeatinterval=100)
button_image_open.place(x=right_x_pos, y=right_y_pos, width=140, height=30)


button_video_open = tk.Button(top, text="동영상 불러오기", command=open_video, repeatdelay=1000, repeatinterval=100)
button_video_open.place(x=right_x_pos + 140 + 5, y=right_y_pos, width=140, height=30)



right_y_pos += 30 + 5

button_image_origin = tk.Button(top, text="원본 이미지", command=original_image)
button_image_origin.place(x=right_x_pos, y=right_y_pos, width=140, height=30)


button_video_quit = tk.Button(top, text="동영상 종료", command=quit_video)
button_video_quit.place(x=right_x_pos + 140 + 5, y=right_y_pos, width=140, height=30)



right_y_pos += 30 + 5

button_predict = tk.Button(top, text="Prediction", command=prediction)
button_predict.place(x=right_x_pos, y=right_y_pos, width=140, height=30)


button_face_detection = tk.Button(top, text="face detection", command=toggle_face_detection)
button_face_detection.place(x=right_x_pos + 140 + 5, y=right_y_pos, width=140, height=30)



right_y_pos += 30 + 5

# 카테고리 체크박스
checkbox_frame = tk.Frame(top)
checkbox_frame.place(x=right_x_pos, y=right_y_pos, width=300, height=180)

model_dir = './models'

# 모델 디렉토리에서 모든 파일들을 가져옴
model_files = os.listdir(model_dir)

# 확장자가 .hdf5인 파일들의 이름에서 확장자를 제거하여 리스트에 추가
model_names = [file.split('.hdf5')[0] for file in model_files if file.endswith('.hdf5')]


label_category = tk.Label(checkbox_frame, text="prediction category")
label_category.grid(row=0, column=0, columnspan=3, padx=3, pady=3, sticky="w")
# 모델명 카테고리 체크박스 생성
if model_names:
    for i, name in enumerate(model_names):
        var = tk.BooleanVar()
        checkbox = tk.Checkbutton(checkbox_frame, text=name, variable=var,
                                  command=lambda n=name: update_checkbox_list(n))
        checkbox.grid(row= i//3 +1, column= i%3, sticky="w")
else:
    label_no_category = tk.Label(checkbox_frame, text="no model")
    label_no_category.grid(row=1, column=0)



right_y_pos += 180 + 5

# font 컬러, 사이즈
text_frame = tk.Frame(top)
text_frame.place(x=right_x_pos, y=right_y_pos, width=290, height=90)

label_text_color = tk.Label(text_frame, text="text color")
label_text_color.grid(row=0, column=0, columnspan=3, sticky="w")

label_r = tk.Label(text_frame, text="R:")
label_r.grid(row=1, column=0, padx=3, pady=3)
entry_r = tk.Entry(text_frame, width=4)
entry_r.grid(row=1, column=1, padx=3, pady=3)
entry_r.insert(0, "255") # 기본값 설정
entry_r.bind("<KeyRelease>", lambda event: update_text_color())

label_g = tk.Label(text_frame, text="G:")
label_g.grid(row=1, column=2, padx=3, pady=3)
entry_g = tk.Entry(text_frame, width=4)
entry_g.grid(row=1, column=3, padx=3, pady=3)
entry_g.insert(0, "255")
entry_g.bind("<KeyRelease>", lambda event: update_text_color())

label_b = tk.Label(text_frame, text="B:")
label_b.grid(row=1, column=4, padx=3, pady=3)
entry_b = tk.Entry(text_frame, width=4)
entry_b.grid(row=1, column=5, padx=3, pady=3)
entry_b.insert(0, "0")
entry_b.bind("<KeyRelease>", lambda event: update_text_color())

color_choose_button = tk.Button(text_frame, command=choose_text_color, bg="yellow", width=3)
color_choose_button.grid(row=1, column=6, padx=10, pady=3)

label_font_size = tk.Label(text_frame, text="font size")
label_font_size.grid(row=2, column=0, columnspan=3, sticky="w")
scale_font_size = tk.Scale(text_frame, from_=1, to=5, orient=tk.HORIZONTAL, showvalue=False, tickinterval=1, command = choose_font_size, length=150, width=15)
scale_font_size.set(3) # 초기값 설정
scale_font_size.grid(row=2, column=3, columnspan=4)



right_y_pos += 90 + 5

# 이미지 설정
image_frame = tk.Frame(top)
image_frame.place(x=right_x_pos, y=right_y_pos, width=290, height=60)

label_image_scale = tk.Label(image_frame, text="image scale")
label_image_scale.grid(row=1, column=0, sticky="w")
scale_image_scale = tk.Scale(image_frame, from_=1, to=20, orient=tk.HORIZONTAL, command = choose_image_scale, length=150, width=15)
scale_image_scale.set(10) # 초기값 설정
scale_image_scale.grid(row=1, column=1)



right_y_pos += 60 + 5
right_x_pos = 5 + imageWnd_width + 5

textLog = st.ScrolledText(top,
                            width = 30,
                            height = 8,
                            font = ("Times New Roman",10))
textLog.place(x=right_x_pos, y=right_y_pos, width=290, height=100)





#메뉴
menubar = Menu(top, background='#ff8000', foreground='black', activebackground='white', activeforeground='black')  

file = Menu(menubar, tearoff=1)
file.add_command(label="Open",command=open_image)
file.add_separator()  
file.add_command(label="Save",command=save_file)
file.add_command(label="Save As",command=save_as_file) 
file.add_separator()   
file.add_command(label="Close",command=close_image)
file.add_separator()  
file.add_command(label="Exit", command=close_window)  
menubar.add_cascade(label="File", menu=file)  

edit = Menu(menubar, tearoff=0)  
edit.add_command(label="Undo")  
edit.add_separator()     
edit.add_command(label="Cut")  
edit.add_command(label="Copy")  
edit.add_command(label="Paste")  
menubar.add_cascade(label="Edit", menu=edit)  

help = Menu(menubar, tearoff=0)  
help.add_command(label="About", command=about)  
menubar.add_cascade(label="Help", menu=help)  

top.config(menu=menubar)

top.mainloop()





