import unittest;

class TestExamples(unittest.TestCase):

    def test_sum(self):
        self.assertEqual(sum([5,15,10]), 
                30, "should be 30");

    def test_split(self):
        s="Hello World";
        e=["Hello","World"];
        self.assertEqual(s.split(" "),e);
        self.assertNotEqual(s, e);
        self.assertIsNotNone(s);
        self.assertIsNot(s,e);
        #self.assertIs(s,e);
        self.assertIsInstance(s,str);

    
if __name__ == '__main__':
    unittest.main();

