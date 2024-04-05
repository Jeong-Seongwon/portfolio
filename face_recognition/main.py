# -*- coding: utf-8 -*-
"""
Created on Fri Mar 29 17:36:08 2024

@author: 602-24



이미지가 없는 경우 처리
"""

import os
import tkinter as tk
import tkinter.scrolledtext as st
import tkinter.filedialog as fd
import cv2
import numpy as np
from PIL import Image
from PIL import ImageTk
from tensorflow.keras.models import load_model


filename = "./data/video/test.mp4"
cap = cv2.VideoCapture(filename)
# cv2.VideoCapture(0) 0은 내장된 기본캠, 외부 연결 카메라는 1부터 시작

hdf5_file = "./models/face.hdf5"
model = load_model(hdf5_file)
image_w = 128
image_h = 128

skip_frames = 20  # 얼굴 감지 수행 프레임
faces = []
result_face_recognize = ""


def MyLog(msg):
    # scrolled text print...
    textLog.insert(tk.INSERT, msg + "\r\n")
    textLog.see("end")

def update_video():
    global faces
    
    if not paused:
        ret, frame = cap.read()
        if ret:
            photo = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # 매 skip_frames번째 프레임에서만 얼굴 감지 수행
            if cap.get(cv2.CAP_PROP_POS_FRAMES) % skip_frames == 0:
                # OpenCV의 얼굴 검출을 위한 분류기를 로드합니다.
                face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    
                gray = cv2.cvtColor(photo, cv2.COLOR_RGB2GRAY)
                
                blur = cv2.GaussianBlur(gray, (5,5), 0)
                # 얼굴 감지
                faces = face_cascade.detectMultiScale(blur, scaleFactor=1.1, minNeighbors=3, minSize=(30, 30))
                
                if len(faces) == 1:
                    (x,y,w,h) = faces[0]
                    x -= int(0.2 * w)
                    y -= int(0.2 * h)
                    w = int(1.4 * w)
                    h = int(1.4 * h)
                    
                    roi = blur[y:y+h, x:x+w]
                    # roi 이미지의 크기가 유효한지 확인
                    if roi.shape[0] > 0 and roi.shape[1] > 0:
                        prediction(roi) # 모델 예측

            # 감지된 얼굴 주위에 사각형 그리기
            for (x, y, w, h) in faces:
                # 머리 크기까지 사각형 확장
                x -= int(0.2 * w)
                y -= int(0.2 * h)
                w = int(1.4 * w)
                h = int(1.4 * h)
                
                cv2.rectangle(photo, (x, y), (x+w, y+h), (0, 255, 0), 2)
                cv2.putText(photo, result_face_recognize, (x+5,y+h-5), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

            img = Image.fromarray(photo) # return photo object
            
            imgTK = ImageTk.PhotoImage(image=img) # tkinter 호환 이미지로 변경
            
            canvas.config(width=imgTK.width(), height=imgTK.height())

            canvas.create_image(0,0,anchor="nw",image=imgTK)
            canvas.image = imgTK
        
        else:
            cap.set(cv2.CAP_PROP_POS_FRAMES, 0) # 동영상이 끝났으면 다시 시작

        window.after(20, update_video)

def prediction(image):
    global result_face_recognize
    # 이미지를 모델 입력에 맞게 변환
    pre = cv2.resize(image, (image_w, image_h))
    
    face_roi = np.expand_dims(pre, axis=0) # 배치 차원 추가

    predictions = model.predict(face_roi)[0]
    #print(predictions) #예측 결과 프린트
    
    # 가장 높은 확률을 가진 클래스의 인덱스 추출
    predicted_class_index = np.argmax(predictions)
    
    labels =  os.listdir("./data/archive")
    label = labels[predicted_class_index]
    
    # 학습된 얼굴 클래스에 대한 확률 추출
    known_face_probability = predictions[predicted_class_index]
    
    # 이상 감지 임계값을 설정하여 이상 감지 수행
    threshold = 0.5  # 적절한 임계값으로 조정
    if known_face_probability < threshold:
        MyLog("이상 감지: 학습되지 않은 얼굴입니다.")
        result_face_recognize = "Not training"
    if label == "00":
        MyLog("Unknown face")
        result_face_recognize = "Unknown face"
    else:
        MyLog("학습된 얼굴입니다. " + label)
        result_face_recognize = "No. "+label


paused = False
play_button_text = "Pause"

def toggle_play_pause():
    global paused, play_button_text
    paused = not paused
    
    if play_button_text == "Pause":
        play_button_text = "Play"
    else:
        play_button_text = "Pause"
    
    play_button.config(text=play_button_text)
    
def on_canvas_click(event):
    toggle_play_pause()

def play_pause():
    toggle_play_pause()

def backward():
    cap.set(cv2.CAP_PROP_POS_FRAMES, cap.get(cv2.CAP_PROP_POS_FRAMES) - 10 * cap.get(cv2.CAP_PROP_FPS))
    check_pause()

def forward():
    if (cap.get(cv2.CAP_PROP_POS_FRAMES) + 10 * cap.get(cv2.CAP_PROP_FPS)) < (cap.get(cv2.CAP_PROP_FRAME_COUNT) - 1):
        cap.set(cv2.CAP_PROP_POS_FRAMES, cap.get(cv2.CAP_PROP_POS_FRAMES) + 10 * cap.get(cv2.CAP_PROP_FPS))
        check_pause()
    else:
        latest()

def latest():
    cap.set(cv2.CAP_PROP_POS_FRAMES, cap.get(cv2.CAP_PROP_FRAME_COUNT) - 1)
    check_pause()

def close():
    if cap.isOpened():
        cap.release()
    window.destroy()

def on_key_press(event):
    if event.keysym == "space":
        toggle_play_pause()
    
    if event.keysym == "Left":
        backward()

    if event.keysym == "Right":
        forward()
        
def check_pause():
    if paused == True:
        toggle_play_pause()
    
def video_open():
    global filename, cap
    global faces, result_face_recognize
    
    filename = fd.askopenfilename(initialdir='./data/video/',title="select a file",
                                            filetypes=(("Video files", "*.mp4;*.avi"),
                                                       ("all files","*.*")))
    if filename:
        if cap is not None and cap.isOpened():
            cap.release()
            faces = []
            result_face_recognize = ""
            
        cap = cv2.VideoCapture(filename)
        check_pause()
        update_video()



# Tk 객체 생성
window = tk.Tk()
window.title("face")

canvas = tk.Canvas(window, bg="black")
canvas.grid(row=0, column=0, padx=3, pady=3)
# 캔버스에 클릭 이벤트 바인딩
canvas.bind("<Button-1>", on_canvas_click)


play_frame = tk.Frame(window)
play_frame.grid(row=1, column=0, padx=3, pady=3)

back_button = tk.Button(play_frame, text="Back", width=10)
back_button.grid(row=0, column=0, padx=3, pady=3)

backward_button = tk.Button(play_frame, text="Backward", width=10, command=backward)
backward_button.grid(row=0, column=1, padx=3, pady=3)

play_button = tk.Button(play_frame, text=play_button_text, width=10, command=play_pause)
play_button.grid(row=0, column=2, padx=3, pady=3)

forward_button = tk.Button(play_frame, text="Forward", width=10, command=forward)
forward_button.grid(row=0, column=3, padx=3, pady=3)

latest_button = tk.Button(play_frame, text="Latest", width=10, command=latest)
latest_button.grid(row=0, column=4, padx=3, pady=3)

# 키보드 바인딩
window.bind("<space>", on_key_press)
window.bind("<Left>", on_key_press)
window.bind("<Right>", on_key_press)

textLog = st.ScrolledText(window,
                            width = 30,
                            height = 8,
                            font = ("Times New Roman",10))
textLog.grid(row=0, column=1, padx=3, pady=3)

video_open_button = tk.Button(window, text="video_open", command=video_open)
video_open_button.grid(row=1, column=1, padx=3, pady=3)


update_video()

window.protocol("WM_DELETE_WINDOW", close)

window.mainloop()
