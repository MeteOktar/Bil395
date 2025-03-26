with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure adacalc is

   type Operand is record
      Value : Float;
   end record;

   -- Function to evaluate addition
   function Add(X, Y : Float) return Float is
   begin
      return X + Y;
   end Add;

   -- Function to evaluate subtraction
   function Subtract(X, Y : Float) return Float is
   begin
      return X - Y;
   end Subtract;

   -- Function to evaluate multiplication
   function Multiply(X, Y : Float) return Float is
   begin
      return X * Y;
   end Multiply;

   -- Function to evaluate division
   function Divide(X, Y : Float) return Float is
   begin
      if Y = 0.0 then
         Put_Line("Error: Division by zero!");
         return 0.0;
      else
         return X / Y;
      end if;
   end Divide;

   Num1, Num2, Result : Float;
   Operator : Character;

begin
   -- Input the first number
   Put("Enter first number: ");
   Get(Item => Num1);

   -- Input the operator
   Put("Enter operator (+, -, *, /): ");
   Get(Operator);

   -- Input the second number
   Put("Enter second number: ");
   Get(Item => Num2);

   -- Perform the operation based on the operator entered
   case Operator is
      when '+' =>
         Result := Add(Num1, Num2);
      when '-' =>
         Result := Subtract(Num1, Num2);
      when '*' =>
         Result := Multiply(Num1, Num2);
      when '/' =>
         Result := Divide(Num1, Num2);
      when others =>
         Put_Line("Invalid operator.");
         return;
   end case;

   -- Output the result in normal format (not scientific notation)
   Put("Result: ");
   Put(Item => Result, Fore => 1, Aft => 6);  -- 6 decimal places for clarity
   New_Line;

end adacalc;
