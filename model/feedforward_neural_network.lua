-- Dataset
dataset = {};
function dataset:size() return 100 end
for i = 1, dataset:size() do
    local input = torch.randn(2);
    local output = torch.Tensor(1);
    if input[1] * input[2] > 0 then
        output[1] = -1;
    else
        output[1] = 1;
    end
    dataset[i] = {input, output}
end

-- Neural Network
require "nn"
mlp = nn.Sequential();
inputs = 2; outputs = 1; HUs = 20;
mlp:add(nn.Linear(inputs, HUs))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(HUs, outputs))

-- Training
criterion = nn.MSECriterion()
trainer = nn.StochasticGradient(mlp, criterion)
trainer.learningRate = 0.01
trainer:train(dataset)

x = torch.Tensor(2)
x[1] = 0.5; x[2] = 0.5; print(mlp:forward(x))
x[1] = 0.5; x[2] = -0.5; print(mlp:forward(x))
x[1] = -0.5; x[2] = 0.5; print(mlp:forward(x))
x[1] = -0.5; x[2] = -0.5; print(mlp:forward(x))
