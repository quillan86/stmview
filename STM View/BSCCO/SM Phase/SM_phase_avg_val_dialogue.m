function SM_phase_avg_val_dialogue(data,obj_handle)
if ~isfield(data,'SM_phase')
    display('SM Phase information not found in data structure')
    return;
end

avg_data = kernel_avg_data(data,data.SM_phase,10);
new_data = guidata(obj_handle);
new_data.SM_phase_avg = avg_data;
guidata(obj_handle,new_data);

end