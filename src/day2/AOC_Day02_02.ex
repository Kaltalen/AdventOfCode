defmodule Main do

  defmodule ListOperation do
    def replacepos(list, pos, val) do
      tempList = List.delete_at(list, pos)
      List.insert_at(tempList, pos, val)
    end
  end

  input_program = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,6,19,23,2,23,6,27,1,5,27,31,1,10,31,35,2,6,35,39,1,39,13,43,1,43,9,47,2,47,10,51,1,5,51,55,1,55,10,59,2,59,6,63,2,6,63,67,1,5,67,71,2,9,71,75,1,75,6,79,1,6,79,83,2,83,9,87,2,87,13,91,1,10,91,95,1,95,13,99,2,13,99,103,1,103,10,107,2,107,10,111,1,111,9,115,1,115,2,119,1,9,119,0,99,2,0,14,0]
  
  defmodule LoopThroughArray do
   def runcommand(list, n) when n >= length(list)-1 do
      IO.puts Enum.at(list,0)
   end
   def runcommand(list, n) do
      command = Enum.at(list,n)
      p1 = Enum.at(list,n+1)
      p2 = Enum.at(list,n+2)
      p3 = Enum.at(list,n+3)
      v1 = Enum.at(list,p1)
      v2 = Enum.at(list,p2)
      
      cond do
        command == 99 ->
          #p0 = Enum.at(list,0)
          #IO.puts "Got 99 element 0 is: #{p0}"
          Enum.at(list,0)
        command == 1 ->
          vsum = v1+v2
          #IO.puts "Add #{v1} #{v2} = #{vsum}"
          newList = ListOperation.replacepos(list, p3, vsum)
          runcommand(newList, n + 4)
        command == 2 ->
          vprod = v1*v2
          #IO.puts "Multiply #{v1} #{v2} = #{vprod}"
          newList = ListOperation.replacepos(list, p3, vprod)
          runcommand(newList, n + 4)
        true ->
          IO.puts "error"
      end
   end
  end
  
  defmodule IntCodeMachine do
    def run(input_program, noun, verb) do
      input_program_temp  = ListOperation.replacepos(input_program, 1, noun)
      input_program_new  = ListOperation.replacepos(input_program_temp, 2, verb)  
      #IO.puts Enum.join(input_program_new, ", ")
      pos0= LoopThroughArray.runcommand(input_program_new, 0)
      if pos0 == 19690720 do
        IO.puts("Starting with noun: #{noun} and verb: #{verb}")
        IO.puts pos0
      end
      #IO.puts("Finished")
    end
  end

  defmodule Loop do
   def for(input_program,n,to) when n < to do
     Loop.for_embedded(input_program,n,0,to)
     Loop.for(input_program,n+1,to)
   end
   def for(input_program,n,to) when n == to do
     Loop.for_embedded(input_program,n,0,to)
   end
   def for_embedded(input_program,n,m,to) when m < to do
     IntCodeMachine.run(input_program, n, m)
     Loop.for_embedded(input_program,n,m+1,to)
   end
   def for_embedded(input_program,n,m,to) when m == to do
     IntCodeMachine.run(input_program, n, m)
   end
  end
  
  Loop.for(input_program,0,99)
  
  
end

