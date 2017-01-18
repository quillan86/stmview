function data = read_map_NN
%cd ('C:\Data');
[filename,pathname]=uigetfile('*','Select Data File(*.sxm,*.3ds)');
%pathname
if filename == 0;
    data = [];
    return;
end
data = 1;
filetype = filename(end-2:end);
cd (pathname);
switch filetype
    case '3ds'     %3ds maps
         [data_T,data_out] = read_nanonis_3ds(filename);
         IMG(data_T); IMG(data_out);
    case 'sxm'     %sxm which can contain single layer LIY files in feedback
        data = read_nanonis_sxm(filename);
        IMG(data);
    otherwise
        data = '';
        disp('Invalid Data Type');
        return;
end

