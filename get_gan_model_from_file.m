function [gan_model] = get_gan_model_from_file(model_file)
%GET_GAN_MODEL_FROM_FILE Summary of this function goes here
%   Input file path as string
gan_model = importTensorFlowNetwork(model_file);
end



% Alternativly can directly call python function from matlab
% output = py.function_name(arguments);

