function rm_center_dialogue(data)

prompt={'Enter Width of Center Portion for Subtraction','0 - for cylinder/ 1 - for Gaussian'};
name='Center Removal for FT Image';
numlines=1;
defaultanswer= {'0','0'};
answer = inputdlg(prompt,name,numlines,defaultanswer);    
if isempty(answer)
    return;
end

sigma = str2double(answer{1});
option = str2double(answer{2});
if option == 0
    new_img = rm_center_cylinder(data.map,sigma);
elseif option == 1
new_img = rm_center(data.map,sigma);
else
    display('Invalid Input')
    return;
end

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.var = [new_data.var '_center-rm_'];
    new_data.ops{end+1} = ['Center removed with width ' answer{1}];
    IMG(new_data);   
else
    new_data = new_img;
    img_plot2(new_data,Cmap.Blue2,'Center Removed');
end

end