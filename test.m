roi = input('Type: ','s')
roi2 = input('Type: ','s')

roi_pairs = {roi, roi2}

while isequal(questdlg('Would you like to select more ROI pairs?','Select more?'), 'Yes')
roi = input('Type: ','s')
roi2 = input('Type: ','s')
	
roi_pairs = cat(1, roi_pairs, {roi, roi2})
end

if questdlg('Would you like to select more ROI pairs?','Select more?') == 'No'
	disp('done')
end