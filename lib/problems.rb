require_relative './stack.rb'

# Time Complexity: O(n), had to read every char
# Space Complexity: O(n), may need inventory[] of size n, such as cases of "((((("
def balanced(string)
  # going from index 0, take inventory of each character until end of string is reached
  # with each char, evaluate the logic of their existence based on inventory taken so far
  # if char is a opener, add to inventory
  # if char is a closer, remove pairing opener from inventory (which needs to be at index -1), else return false
  return true if string == ''

  inventory = Stack.new()
  openers = ['{', '[', '(']
  closers = {'}' => '{', ']' => '[', ')' => '('}

  index = 0
  until index == string.length
    currChar = string[index]

    if openers.include? currChar
      inventory.push(currChar)

    elsif closers.keys.include? currChar
      return false if inventory.empty?
      if inventory.getLast() == closers[currChar]
        inventory.pop()
      else 
        return false
      end

    else  
      # Unexpected character in string, error!
      return false
    end

    index += 1
  end

  # at the end, everything should be matched and inventory shoudl be empty
  return inventory.empty?
end

# Time Complexity: ?
# Space Complexity: ?
def evaluate_postfix(postfix_expression)
  # ASSUMING that all operands are single digit integers 
  stack = Stack.new()
  operations = %w[+ - * /]
  ints = %w[0 1 2 3 4 5 6 7 8 9]

  index = 0
  until index == postfix_expression.length
    currChar = postfix_expression[index]

    if ints.include? currChar
      stack.push(currChar.to_i)
    
    elsif operations.include? currChar 
      operand_2nd = stack.pop()
      operand_1st = stack.pop()
      
      if (operand_1st.class != Integer) || (operand_2nd.class != Integer)
        return "ERROR! Can't do math on non-Integers #{operand_1st} and/or #{operand_2nd}!"
      end

      case currChar
      when '+'
        result = operand_1st + operand_2nd
      when '-'
        result = operand_1st - operand_2nd
      when '*'
        result = operand_1st * operand_2nd
      when '/'
        result = operand_1st / operand_2nd
      end

      stack.push(result)

    else
      return "ERROR! unexpected character #{currChar}!"
    end

    index += 1
  end

  # there should be only 1 element left in the stack
  answer = stack.pop()
  if stack.empty?
    return answer 
  else
    return "ERROR! More than 1 element left in stack, how?!"
  end
end
