# -*- coding: utf-8 -*-
"""
Created on Tue Apr  2 16:00:25 2024

@author: 602-24
"""

import os
import cv2
import numpy as np
from PIL import Image
from sklearn.model_selection import train_test_split
import tensorflow as tf

epochs = 15
image_w = 128
image_h = 128

data_path = "./data/archive"
hdf5_file = "./models/face.hdf5" # 모델 저장 위치

def model_train():
    images = []
    labels = []
    for label in os.listdir(data_path):
        label_path = os.path.join(data_path, label)
        if os.path.isdir(label_path):
            for filename in os.listdir(label_path):
                img_path = os.path.join(label_path, filename)
    
                pil_image = Image.open(img_path)
                np_image = np.array(pil_image)
                cv_image = cv2.cvtColor(np_image, cv2.COLOR_RGB2BGR)
                gray = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)
                
                image = cv2.resize(gray, (image_w, image_h))
    
                if image is not None:
                    images.append(image)
                    labels.append(label)
                    
    images = np.array(images)
    labels = np.array(labels)
    
    X_train, X_test, y_train, y_test = train_test_split(images, labels, test_size=0.1, random_state=42)
    # 라벨을 정수로 변환
    label_to_index = {label: idx for idx, label in enumerate(np.unique(labels))}
    y_train = np.array([label_to_index[label] for label in y_train])
    y_test = np.array([label_to_index[label] for label in y_test])
    
    # 데이터 정규화
    X_train = X_train.astype('float32') / 255.0
    X_test = X_test.astype('float32') / 255.0
    
    # 새로운 모델 생성
    model = tf.keras.models.Sequential([
        tf.keras.layers.Conv2D(64, (3, 3), padding='same', activation='relu', input_shape=(image_w, image_h, 1)),
        tf.keras.layers.MaxPooling2D((2, 2)),
        tf.keras.layers.Conv2D(128, (3, 3), padding='same', activation='relu'),
        tf.keras.layers.MaxPooling2D((2, 2)),
        tf.keras.layers.Conv2D(256, (3, 3), padding='same', activation='relu'),
        tf.keras.layers.MaxPooling2D((2, 2)),
        tf.keras.layers.Conv2D(512, (3, 3), padding='same', activation='relu'),
        tf.keras.layers.MaxPooling2D((2, 2)),
    
        tf.keras.layers.Flatten(),
        tf.keras.layers.Dense(512, activation='relu'),
        tf.keras.layers.Dense(len(label_to_index), activation='softmax')
    ])
    
    # 모델 컴파일
    model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    
    # 모델 요약 확인
    print(model.summary())
    
    # 모델 학습
    model.fit(X_train, y_train, validation_data=(X_test, y_test), epochs=epochs)
    
    # 모델 저장하기
    model.save(hdf5_file)
    
    # 모델 평가
    score = model.evaluate(X_test, y_test)
    print('loss=', score[0])        # loss
    print('accuracy=', score[1])    # acc
    

if __name__=="__main__":
    model_train()