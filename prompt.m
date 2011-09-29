prompt = {'Seed Count:', 'FA Threshold:', 'Step Size:', 'Turning Angle:', 'Smoothing:', 'Minimum Length:','Maximum Length:', 'Thread Count:'};
dlg_title = 'Specify Parameters for Batch Tracking';
def_ans = {'113,586,000','0.0241','0.5','80','0.85','20','140','1'};
options.Resize = 'on';
params_answers = inputdlg(prompt,dlg_title,num_lines,def_ans,options)

seed_count = str2num(char(strrep((params_answers(1)), ',', '')))
fa_threshold = str2num(char(params_answers(2)))
step_size = str2num(char(params_answers(3)))
turning_angle = str2num(char(params_answers(4)))
smoothing = str2num(char(params_answers(5)))
min_length = str2num(char(params_answers(6)))
max_length = str2num(char(params_answers(7)))
thread_count = str2num(char(params_answers(8))



TEST * TEST * TEST

prompt = {'Seed Count:', 'FA Threshold:', 'Step Size:'};
dlg_title = 'Specify Parameters for Batch Tracking';
def_ans = {'1','2','3'}
options.Resize = 'on'
params_answers = inputdlg(prompt,dlg_title,num_lines,def_ans,options)

seed_count = strrep((params_answers(1), , )

params_answers(1:end)


for params_answers(1:end)
 ...
 ...
for i = 1:size(roi_pairs, 1)
	strn = sprintf('--action=trk %s %s', roi_pairs(i), roi_pairs(i, 2))
	 ...
 ...
for i = roi_pairs(1:end)