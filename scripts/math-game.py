#!/usr/bin/env python
# %%
from abc import abstractmethod
from random import choice
from dataclasses import dataclass

class ANSIEscape:
    
    # Text Formatting
    FORMATTING ={
        "reset" : "\033[0m",
        "bold" : "\033[1m",
        "dim" : "\033[2m",
        "underline" : "\033[4m",
        "blink" : "\033[5m",
        "reverse" : "\033[7m",
        "hide" : "\033[8m"
    }

    # Foreground Colors
    COLORS = {
        "black": "\033[30m",
        "red": "\033[31m",
        "green": "\033[32m",
        "yellow": "\033[33m",
        "blue": "\033[34m",
        "magenta": "\033[35m",
        "cyan": "\033[36m",
        "white": "\033[37m"
    }

    # Background Colors
    BACKGROUNDS = {
        "black": "\033[40m",
        "red": "\033[41m",
        "green": "\033[42m",
        "yellow": "\033[43m",
        "blue": "\033[44m",
        "magenta": "\033[45m",
        "cyan": "\033[46m",
        "white": "\033[47m"
    }

    # Cursor Control
    @staticmethod
    def move_cursor_up(n=1):
        """Move the cursor up by n lines."""
        print(f"\033[{n}A", end='')

    @staticmethod
    def move_cursor_down(n=1):
        """Move the cursor down by n lines."""
        print(f"\033[{n}B", end='')

    @staticmethod
    def move_cursor_forward(n=1):
        """Move the cursor forward by n columns."""
        print(f"\033[{n}C", end='')

    @staticmethod
    def move_cursor_back(n=1):
        """Move the cursor back by n columns."""
        print(f"\033[{n}D", end='')

    @staticmethod
    def move_cursor_x_y(x=1, y=1):
        """Move the cursor back by n columns."""
        print(f"\033[{y};{x}H", end='')

    @staticmethod
    def save_cursor_position():
        """Save the cursor position."""
        print("\033[s", end='')

    @staticmethod
    def restore_cursor_position():
        """Restore the cursor position."""
        print("\033[u", end='')

    # Clearing Text
    @staticmethod
    def clear_line():
        """Clear the current line."""
        print("\033[2K", end='')

    @staticmethod
    def clear_from_cursor_to_end_of_line():
        """Clear from cursor to end of line."""
        print("\033[K", end='')

    @staticmethod
    def clear_from_cursor_to_start_of_line():
        """Clear from cursor to start of line."""
        print("\033[1K", end='')

    @staticmethod
    def clear_entire_line():
        """Clear entire line."""
        print("\033[2K", end='')

    @staticmethod
    def clear_from_cursor_to_end_of_screen():
        """Clear from cursor to end of screen."""
        print("\033[J", end='')

    @staticmethod
    def clear_from_cursor_to_start_of_screen():
        """Clear from cursor to start of screen."""
        print("\033[1J", end='')

    @staticmethod
    def clear_screen():
        """Clear the entire screen."""
        print("\033[2J", end='')

    @staticmethod
    def clear_terminal():
        """
        ANSI Escape Sequences
        This sends an escape sequence to the terminal that:
            - removes the cursor to the top left \033[H
            - clears the screen \033[J
        """    
        print("\033[H\033[J", end="")

    # Hiding/Showing Cursor
    @staticmethod
    def hide_cursor():
        """Hide the terminal cursor."""
        print("\033[?25l", end='')

    @staticmethod
    def show_cursor():
        """Show the terminal cursor."""
        print("\033[?25h", end='')

    # Methods to apply colors and formatting
    @classmethod
    def format_text(cls, text, color=None, background=None, bold=False, underline=False, blink=False, reverse=False):
        """Format the text with the given styles."""
        styles = []

        # Text color
        if color and color in cls.COLORS:
            styles.append(cls.COLORS[color])
        # Background color
        if background and background in cls.BACKGROUNDS:
            styles.append(cls.BACKGROUNDS[background])
        # Text styles
        if bold:
            styles.append(cls.FORMATTING['bold'])
        if underline:
            styles.append(cls.FORMATTING['underline'])
        if blink:
            styles.append(cls.FORMATTING['blink'])
        if reverse:
            styles.append(cls.FORMATTING['reverse'])

        # Apply styles and reset at the end
        return f"{''.join(styles)}{text}{cls.FORMATTING['reset']}"
    
    @classmethod
    def print(cls, text, color=None, background=None, bold=False, underline=False, blink=False, reverse=False):
        """Print the text with the given styles."""
        print(cls.format_text(text, color, background, bold, underline, blink, reverse))

    @classmethod
    def print_with_border(cls, text, color=None, background=None, bold=False, underline=False, blink=False, reverse=False):
        """Print text with a simple border around it."""
        border = '+' + '-' * (len(text) + 2) + '+'
        text = cls.format_text(text, color, background, bold, underline, blink, reverse)
        print(border)
        print(f"| {text} |")
        print(border)

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
    ANSIEscape.clear_terminal()
    print("\n"*3)
    a = choice(range(min_value, max_value+1))
    b = choice(range(min_value, max_value+1))

    op = choice([Sum, Sub, Mul, Div, Mod, DivMod])
    op = op(a, b)
    answer = input(f"{op.question()} = ")

    validation = op.validate(answer)
    print(validation)
    if not validation:
        print(f"{op.answer()}\n")
    
    exit = input("\nEnter e to exit, or any other key to continue\n: ")

    if exit == 'e':
        break

# %%

# %%
