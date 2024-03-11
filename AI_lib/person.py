class Person:
    def __init__(self, name, age, address):
        self.name=name
        self.age=age
        self.address=address
    
    def greeting(self):
        print("안녕하세요, 저는 {0}입니다".format(self.name))
    
    def info(self):
        print(f"이름 : {self.name}, 나이 : {self.age}")
        
class Student(Person):
    def info(self):
        print(f"이름 : {self.name}, 나이 : {self.age}, 주소 : {self.address}")