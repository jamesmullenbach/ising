%script to plot energy per site
for i = 1:10
    N = 100;
    T(i) = rand(0,4);
    B = 0;
    steps = 80;
    [~, eTA] = Ising2D(N, T, B, steps);
    energyPerSite(i) = eTA;
end
plot(T, eTA);
ylabel('energy per site');
xlabel('temperature');

    