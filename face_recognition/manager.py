# -*- coding: utf-8 -*-
"""
Created on Thu Apr  4 09:05:39 2024

@author: 602-24
"""


import time
import os
import cv2
import tkinter as tk
from PIL import Image, ImageTk
import tkinter.scrolledtext as st
import threading

import train_model


class Manager():
    def __init__(self):
        filename = "./data/video/train2.mp4"
        self.cap = cv2.VideoCapture(filename)
        self.faces = []
        
        self.run()
    
    
    def join(self):
        self.num = self.num_entry.get()
        
        self.picture()
    
        self.window_join()
        
    
    def window_join(self):
        self.join_window = tk.Toplevel(self.window)
        self.join_window.title("Join")
        self.join_window.geometry("300x600")
        
        # 디렉토리에서 모든 파일들을 가져옴
        image_files = os.listdir(self.folder_path)

        # jpg 파일들의 이름에서 확장자를 제거하여 리스트에 추가
        image_names = [file.split('.jpg')[0] for file in image_files if file.endswith('.jpg')]

        self.label_image = tk.Label(self.join_window)
        self.label_image.grid(row=0, column=0, padx=3, pady=3)
        
        if image_names:
            image_button_frame = tk.Frame(self.join_window, width=280, height=280)
            image_button_frame.grid(row=1, column=0)
            
            for i, name in enumerate(image_names):
                image_path = self.folder_path +"/"+ name +".jpg"
                image = Image.open(image_path)
                image = image.resize((64,64), Image.LANCZOS)
                photo = ImageTk.PhotoImage(image)
                
                image_button = tk.Button(image_button_frame, image=photo, command=lambda image_path=image_path: self.on_image_button_click(image_path))
                image_button.image = photo
                image_button.grid(row= i//3 +1, column= i%3)
                
            join_ok_button = tk.Button(self.join_window, text="ok", command=self.join_ok)
            join_ok_button.grid(row=2, column=0)
            
        else:
            label_no_image = tk.Label(self.join_window, text="no image")
            label_no_image.grid(row=1, column=0)
        
        cancel_button = tk.Button(self.join_window, text="cancel", command=lambda: self.join_window.destroy())
        cancel_button.grid(row=3, column=0)
        
    def on_image_button_click(self, image_path):
            self.display_selected_image(image_path)
    
    def display_selected_image(self, image_path):
        image = Image.open(image_path)
        image = image.resize((256, 256), Image.LANCZOS)
        photo = ImageTk.PhotoImage(image)
        self.label_image.config(image=photo)
        self.label_image.image = photo  # 유지하기 위해 참조를 저장해야 함
    
    def join_thread(self):
        if self.num_entry.get():
            thread = threading.Thread(target=self.join)
            thread.start()
    
    def picture(self):
        wait_time = 2
        image_w = 128
        image_h = 128
        
        # 이미지를 저장할 폴더 경로 설정
        self.folder_path = "./data/archive/" + self.num
        
        if not os.path.exists(self.folder_path):
            os.makedirs(self.folder_path)  # 폴더가 없는 경우 폴더 생성
        
        for i in range(10):
            image_path = os.path.join(self.folder_path, f"{self.num}_{i+1}.jpg")  # 이미지 파일 경로 설정   
            
            for t in range(wait_time):
                self.MyLog(f"{wait_time - t}s...")
                time.sleep(1)
            
            self.MyLog(f"{i+1}번 촬영")
            
            if len(self.faces) > 0:
                (x,y,w,h) = self.faces[0]
                x -= int(0.2 * w)
                y -= int(0.2 * h)
                w = int(1.4 * w)
                h = int(1.4 * h)
                
                roi = self.blur[y:y+h, x:x+w]
                # roi 이미지의 크기가 유효한지 확인
                if roi.shape[0] > 0 and roi.shape[1] > 0:
                    
                    face_roi = cv2.resize(roi, (image_w, image_h))
        
                    cv2.imwrite(image_path, face_roi)
                    
                    self.MyLog(f"picture success...{i+1}")
                
                else:
                    self.MyLog(f"failed picture...{i+1}")
            
        
    def join_ok(self):
        # 모델 학습
        self.MyLog("model training...")
        train_model.model_train()
    
    
    def video_update(self):
        skip_frames = 20  # 얼굴 감지 수행 프레임

        ret, frame = self.cap.read()
        
        if ret:
            photo = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # 매 skip_frames번째 프레임에서만 얼굴 감지 수행
            if self.cap.get(cv2.CAP_PROP_POS_FRAMES) % skip_frames == 0:
                # OpenCV의 얼굴 검출을 위한 분류기를 로드합니다.
                face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    
                gray = cv2.cvtColor(photo, cv2.COLOR_RGB2GRAY)
                
                self.blur = cv2.GaussianBlur(gray, (5,5), 0)
    
                # 얼굴 감지
                self.faces = face_cascade.detectMultiScale(self.blur, scaleFactor=1.1, minNeighbors=3, minSize=(60, 60))
                
            # 감지된 얼굴 주위에 사각형 그리기
            for (x, y, w, h) in self.faces:
                # 머리 크기까지 사각형 확장
                x -= int(0.2 * w)
                y -= int(0.2 * h)
                w = int(1.4 * w)
                h = int(1.4 * h)
                 
                cv2.rectangle(photo, (x, y), (x+w, y+h), (0, 255, 0), 2)

            img = Image.fromarray(photo)
            
            imgTK = ImageTk.PhotoImage(image=img) # tkinter 호환 이미지로 변경
            
            self.canvas.config(width=imgTK.width(), height=imgTK.height())

            self.canvas.create_image(0,0,anchor="nw",image=imgTK)
            self.canvas.image = imgTK
        else:
            self.cap.set(cv2.CAP_PROP_POS_FRAMES, 0) # 동영상이 끝났으면 다시 시작

        self.window.after(20, self.video_update)
    
    
    def run(self):
        self.window = tk.Tk()
        self.window.title("manager")
        
        self.canvas = tk.Canvas(self.window)
        self.canvas.grid(row=0, column=0, rowspan=2, padx=3, pady=3)
        
        
        self.join_frame = tk.Frame(self.window, width=100)
        self.join_frame.grid(row=0, column=1, padx=3, pady=3)
        
        self.num_label = tk.Label(self.join_frame, text="num :")
        self.num_label.pack()
        
        self.num_entry = tk.Entry(self.join_frame)
        self.num_entry.pack()
        
        self.join_button = tk.Button(self.join_frame, text="Join", command=self.join_thread)
        self.join_button.pack()
        
        self.textLog = st.ScrolledText(self.window,
                                    width = 30,
                                    height = 8,
                                    font = ("Times New Roman",10))
        self.textLog.grid(row=1, column=1, padx=3, pady=3)
        
        self.video_update()
        
        self.window.mainloop()

    def MyLog(self, msg):
        # scrolled text print...
        self.textLog.insert(tk.INSERT, msg + "\r\n")
        self.textLog.see("end")



if __name__ == "__main__":
    Manager()