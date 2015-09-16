%%ISING MODEL 2D CODE
function [spins, energyTimeAverage, magnetization] = Ising2D(N, T, B, steps, animate)

J = 1; %% ferromagnetic coupling constant

%%initialize NxN array of spins, randomly chosen to be 1 or -1
spins = round(rand(N));
spins(spins==0) = -1;

%%Compute all the possible energies before looping through
%%array
for i = -8:4:8
    energy(i+9,1) = - (i * J - 2 * B);
    energy(i+9,3) = - (i * J + 2 * B);
end

%%Run at least steps # of Metropolis steps, each one at a random
%%location
energyTimeAverage = 0;
for i = 1:steps
    [spins, energyPerElectron, magPerElectron] = fullMCStep(spins, energy, N, T);
    %%allow steps for system to thermalize
    if i > 20
        energyTimeAverage = energyTimeAverage + energyPerElectron;
        %%fprintf('%d\n', energyPerElectron);
    end
    if animate
        imagesc(spins);
        axis image;
        colormap([0 0 0;1 1 1]);
        drawnow;
    end
end
%%average energy over all steps
energyTimeAverage = energyTimeAverage / (steps - 20);
%%take last value of magnetization
magnetization = magPerElectron;
end