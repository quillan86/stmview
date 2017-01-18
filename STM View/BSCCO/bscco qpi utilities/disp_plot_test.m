

figure

plot(energies.*1000, (q_1_trip_2(:,1) ./bragg),'or');
hold on 
plot(energies.*1000, (q_1_trip_2(:,2) ./bragg),'ob');
plot(energies.*1000, (q_1_trip_2(:,3)./bragg),'og');
hold off

xlim([0 30]);
ylim([0.1 0.8]);
xlabel('Energy/ mV');
ylabel('q / (2\pi / a)')

figure 
plot(energies.*1000, (q(:,1) ./bragg),'or');
hold on 
plot(energies.*1000, (q(:,2) ./bragg),'ob');
plot(energies.*1000, (q(:,3)./bragg),'og');
hold off

xlim([0 30]);
ylim([0.1 0.8]);
xlabel('Energy/ mV');
ylabel('q / (2\pi / a)')
