import inspect;

moduleVar="This is module variable";

class myClass:
    classVar="Class variable";

    def __init__(self):
        #nonlocal globalVar;
        #global globalVar;
        #self.var=globalVar;
        self.var="instance specific var";

    def print_obj_var(self):
        allVars={**globals(),**locals()};
        print("In the method '{0}':".format(inspect.stack()[0][3]));
        if 'moduleVar' in allVars:
            print(f"I can see {moduleVar}");
        if 'classVar' in allVars:
            print(f"I can see {classVar}");
        if myClass.classVar:
            print(f"I can see {myClass.classVar} using myClass.classVar")
        if self.var:
            print("I can see {0}".format(self.var));

if __name__ == "__main__":
    obj1=myClass();
    obj1.print_obj_var();

