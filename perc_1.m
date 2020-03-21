iter = 100;
l_r = 0.0001;
l_r0 = l_r;
w = rand(28,28);
w0 = rand();
y = ones(5000,1);
d = ones(5000,1);
y2 = ones(1000,1);
d2 = ones(1000,1);
for j = 1:5000
    if trainlabels(j) ~= 1
        d(j) = -1;
    end
    if j <= 1000 && testlabels(j) ~= 1
        d2(j) = -1;
    end
end
errors = zeros(100,1);

for i = 1:iter
    for j = 1:5000
        y(j) = predict(x(:,:,j), w);
        update = l_r*(d(j)-y(j))*x(:,:,j);
        w = w + update;
    end
    l_r = l_r/(1+i);
    errors(i) = sum(abs(d-y)/2);
end

num_correct = 0;
for i = 1:1000
    y2(i) = predict(x2(:,:,i), w);
    if y2(i) == d2(i)
        num_correct = num_correct + 1;
    end
end

disp(num_correct/1000);

function p = predict(item, w)
    s = 0;
    for i = 1:28
        s = s + dot(item(i,:),w(i,:));
    end
    if s >= 0
        p = 1;
    else 
        p = -1;
    end
end