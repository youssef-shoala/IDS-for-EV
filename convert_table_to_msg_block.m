data = load("pre_submit_d.mat").data;
startTime = data.Timestamp(1);
data.Timestamp = data.Timestamp - startTime;

numMsgs = max(size(data.Timestamp));


canMsgs.Extended = zeros(1, numMsgs, 'uint8');
canMsgs.Remote = zeros(1, numMsgs, 'uint8');
canMsgs.Error = zeros(1, numMsgs, 'uint8');
canMsgs.Length = uint8(data.DLC)';
canMsgs.Timestamp = data.Timestamp';

canMsgs.ID = zeros(1, numMsgs, 'uint32');
canMsgs.Data = zeros(8, numMsgs, 'uint8');

% convert string to vector of uint8
for i = 1:numMsgs
    cellData = data.Data(i);
    strData = cellData{1};
    hexTokens = strsplit(strData, ' ');
    for j = 1:numel(hexTokens)
        decVal = hex2dec(hexTokens{j});
        canMsgs.Data(j, i) = uint8(decVal);
    end
    strId = data.Arbitration_ID(i);
    decId = hex2dec(strId);
    canMsgs.ID(i) = uint32(decId);
end

save can_msgs_d.mat canMsgs;
