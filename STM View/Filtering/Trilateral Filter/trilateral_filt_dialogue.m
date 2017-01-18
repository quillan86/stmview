function new_data = trilateral_filt_dialogue(data)
       prompt={'Specify Filter Window Size - (px)','Specify Spatial Domain SD',...
           'Specify Intensity Domain SD','Specify Sigma3','Specify Sigma4',...
           'Specify w'};
       name= 'Trilaterial Filter Parameters';
       numlines=1;
       defaultanswer= {'5','3','10','0.1','0.1','1'};
       answer = inputdlg(prompt,name,numlines,defaultanswer); 
       w = str2double(answer{1});
       sigma(1) = str2double(answer{2});
       sigma(2) = str2double(answer{3});
       sigma(3) = str2double(answer{4});
       sigma(4) = str2double(answer{5});
       m = str2double(answer{6});
       [nr nc nz] = size(data.map);
       new_map = zeros(nr,nc,nz);
       old_map = data.map;
      % h = waitbar(0,'Applying bilateral filter to Layers...');
      % set(h,'Name','Bilateral Filter Progress');       
      %matlabpool(4);
       parfor i = 1:nz           
           img = old_map(:,:,i);
           max_val = max(max(img));
           new_map(:,:,i) = trilateral_filt(img/max_val,w,sigma,m)*max_val;
         %  waitbar(i/nz,h,[num2str(i/nz*100) '%']);
       end
      % matlabpool close;
      % close(h);
       new_data = data;
       new_data.map = new_map;
       new_data.var = [new_data.var '_tri_filt'];
       new_data.ops{end+1} = ['Trilaterial Filter - filter width: ' answer{1} ', spatial SD: ' answer{2} ', intensity SD: ' answer{3}];
       IMG(new_data);      
       
end