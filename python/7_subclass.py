# check how parent class metthod can be overriden

class Parent():
    def __init__(self):
        print(self.__class__);
        self.whoami();

    def whoami(self):
        print("I am in class parent " + self.__class__.__name__);


class Child(Parent):
    def __init__(self):
        print("Initializing in Child");
        super(Child, self).__init__();
        
    def whoami(self):
        print("I am in class child " + self.__class__.__name__);


if __name__ == '__main__':
    print("Parent class:");
    Parent();
    print("Child class, method overriden:");
    Child();

