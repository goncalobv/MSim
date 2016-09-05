function E=func_error(y)

    alpha1=y(2);
    alpha2=1.2;
    delta1=-1.2;
    delta2=2.3;
    N1_0=y(1);
    N2_0=10;

    load('presas.mat');
    options = simset('SrcWorkspace','current');
    sim('function_teste',tr,options);

    E=sum(abs(n2-yr));
    
end

