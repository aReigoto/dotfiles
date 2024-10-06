#!/usr/bin/env python
# %%
from abc import abstractmethod
from random import choice
# %%
class Operation:
    def __init__(self, a, b):
        self.a = a
        self.b = b
    
    @abstractmethod
    def question(self):
        pass
    
    @abstractmethod
    def answer(self):
        pass

    def validate(self, answer):
        try:
            t = type(self.answer())
            return t(answer) == self.answer()
        except:
            return False

# %%
class Sum(Operation):
    def question(self):
        return f'{self.a} + {self.b}'
    
    def answer(self):
        return self.a + self.b
    
class Sub(Operation):
    def question(self):
        return f'{self.a} - {self.b}'
    
    def answer(self):
        return self.a - self.b
    
class Mul(Operation):
    def question(self):
        return f'{self.a} * {self.b}'
    
    def answer(self):
        return self.a * self.b
    
class Div(Operation):
    def question(self):
        return f'{self.a} / {self.b}'
    
    def answer(self):
        return self.a / self.b

class Mod(Operation):
    def question(self):
        return f'{self.a} % {self.b}'
    
    def answer(self):
        return self.a % self.b

class DivMod(Operation):
    def question(self):
        return f'{self.a} // {self.b}, {self.a} % {self.b}'
    
    def answer(self):
        return divmod(self.a, self.b)

# %%
"""
Bitwise Operators
& (bitwise and)
| (bitwise or)
^ (bitwise xor)
~ (bitwise not)
<< (left shift)
>> (right shift)
"""
# %%

print("Type 'e' to exit")

min_value = 1
max_value = 10
while True:
    a = choice(range(min_value, max_value+1))
    b = choice(range(min_value, max_value+1))

    op = choice([Sum, Sub, Mul, Div, Mod, DivMod])
    op = op(a, b)
    answer = input(f"{op.question()} = ")

    print(op.validate(answer))
    print(f"answer: {op.question()} = {op.answer()}\n")

    if answer.lower() == 'e':
        break
    

# %%

# %%
