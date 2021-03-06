--here begins the functions for matrix things

--prints the matrix
function makeMatrix(x,y)
	 local ret = {}
	 for i = 1, x do
	     ret[i] = {}
	     for k = 1, y do
	     	 ret[i][k] = 0
	     end
	  end
	  return ret
end


function printMatrix(matrix)
	 s = ""
	 for i , v in ipairs(matrix) do
	      for k , r  in ipairs(v) do 
	      	  s = s .. matrix[i][k] .. " "
	      end
	      s = s .. "\n"
	 end
	 print(s) 
end

--returns the number of data entries in a matrix
function sizeOf(matrix)
	 local size = 0
	 for _ in pairs(matrix) do size = size + 1 end
	 return size
end

function scalar(int , matrix)
	 for i , v in ipairs(matrix) do
	     for k , r in ipairs(v) do
	     	 matrix[i][k] = int * matrix[i][k]
             end
	 end
	 return matrix	
end

function identify(matrix)
	 side = sizeOf(matrix)
	 for i = 1, side do
	     for j = 1, side do
	     	 if (i == j) then matrix[i][j] = 1
		 else matrix[i][j] = 0 end     
	     end
	 end
	 return matrix
end

function matrixMult(matrix1 , matrix2)
	 local tempMatrix = {}
	 for i = 1, sizeOf(matrix1) do
	     tempMatrix[i] = {}
	     for k = 1, sizeOf(matrix2[1]) do
	     	 tempMatrix[i][k] = 0
	     end
	 end
	 for i = 1, sizeOf(matrix1) do
	     for k = 1 , sizeOf(matrix2[1]) do
	     	 for j = 1, sizeOf(matrix1[1]) do
		     --print(j)
		     tempMatrix[i][k] =  tempMatrix[i][k] + matrix1[i][j] * matrix2[j][k]
		     end
		  end
	end
	return tempMatrix	 
end

function translate(x,y,z)
	 local temp = makeMatrix(4,4)
	 identify(temp)
	 temp[1][4] = x
	 temp[2][4] = y
	 temp[3][4] = z
	 return temp
end
sin , cos , pi= math.sin , math.cos, math.pi
function rotate(axis,theta)
	 temp = makeMatrix(4,4)
	 
	 identify(temp)
	 if (axis == "x") then
	    temp[2][2] = cos(theta)
	    temp[2][3] = -1 * sin(theta)
	    temp[3][2] = sin(theta)
	    temp[3][3] = cos(theta)
	 elseif(axis == "y") then
	    temp[3][3] = cos(theta)
	    temp[3][1] = -1 * sin(theta)
	    temp[1][3] = sin(theta)
	    temp[1][1] = cos(theta)
	  else
	    temp[1][1] = cos(theta)
	    temp[1][2] = -1 * sin(theta)
	    temp[2][1] = sin(theta)
	    temp[2][2] = cos(theta)
	  end
	  return temp
end

function scale(x,y,z)
	 temp = makeMatrix(4,4)
	 identify(temp)
	 temp[1][1] = x
	 temp[2][2] = y
	 temp[3][3] = z
	 return temp
end


function hermiteMatrix()
	 local hMatrix = {{2,-2,1,1},{-3,3,-2,-1},{0,0,1,0},{1,0,0,0}}
	 return hMatrix
end

function bezierMatrix()
	 local bMatrix = {{-1,3,-3,1},{3,-6,3,0},{-3,3,0,0},{1,0,0,0}}
	 return bMatrix
end

function coef(x0, y0, x1, y1, x2, y2, x3, y3,t)
	 --print(1)
	 local xcoef, ycoef, matrix
	 if (t == "bezier") then
	    matrix = bezierMatrix()
	    --printMatrix(matrix)
	    xcoef , ycoef = matrixMult(matrix,{{x0},{x1},{x2},{x3}}), matrixMult(matrix , {{y0},{y1},{y2},{y3}})
	 else
	    matrix = hermiteMatrix()
	    xcoef , ycoef = matrixMult(matrix,{{x0},{x1},{x2},{x3}}), matrixMult(matrix , {{y0},{y1},{y2},{y3}})
	 end 
	 return xcoef,ycoef
	 
end


