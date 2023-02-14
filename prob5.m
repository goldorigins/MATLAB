%%Problem 5

A = [1,4,9,16,25;4,9,16,25,36;9,16,25,36,49;16,25,36,49,64;25,36,49,64,81];
B = inv(A);
%norm of A with p = 2
n_A2 = norm(A,2);
n_iA2 = norm(B,2);

o1 = ['Norm of A with p=2:  ',num2str(n_A2)];
o2 = ['Norm of inverse A with p=2:  ',num2str(n_iA2)];
disp(o1)
disp(o2)

r = cond(A,2);

o3 = ['This matrixs condition number by matlab is: ' num2str(r)];
disp(o3)

t = n_A2 * n_iA2;
o4 = ['or calculating with A*invA yeilds: ' num2str(t)];
disp(o4)
disp('This matrix is not well contitioned. This is because the condition number is way bigger than 1')
disp('I do believe this has something to do with the warning Matlab gives')

