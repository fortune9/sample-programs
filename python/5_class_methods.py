
def outside_method():
    print("I am in outside of the class");


class myClass:
    def __init__(self):
        self.name="I am an instance"+self.__class__.__name__;

    def inside_method(self):
        print("I ({0}) am inside of the class".
                format(self.name));

    def method_wo_instance():
        print("This class method has no input values");

    def method_wo_instance_indirect(self):
        method_wo_instance();

if __name__ == "__main__":
    myObj=myClass();
    outside_method();
    myObj.inside_method();
    try:
        myObj.method_wo_instance();
    except:
        print("calling method_wo_instance failed");
    print("callin gmethod_wo_instance_indirect");
    myObj.method_wo_instance_indirect();

