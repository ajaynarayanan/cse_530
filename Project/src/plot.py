from cmath import exp
from parser import collect_experiments

import matplotlib.pyplot as plt


def plot_results(plt_obj, x, y, title, legend_title, color, xlabel, ylabel, kernel_name):
    
    plt_obj = axis
    plt_obj.plot(x, y, marker='o', color=color, linestyle='--', label=legend_title) 
    plt_obj.set_title(title) #, loc='center')
    plt_obj.set_xlabel(xlabel)
    plt_obj.set_ylabel(ylabel)    
    plt_obj.legend()
    # plt.savefig(f"{kernel_name}.jpg", bbox_inches='tight')

results = collect_experiments()

colr = "green"
figure, axis = plt.subplots(nrows=1, ncols=1, sharex=False,)
for kernel in results:
    x = []
    y = []
    z = [(key, val["KERNEL_POWER"]) for key, val in results[kernel].items() if int(key.split("_")[-2]) > 10 ]
    z.sort(key=lambda v: int(v[0].split("_")[-2]))
    x  = [(v[0].split("_")[-2]) for  v in z]
    y  = [v[1][1] for v in z]
    print(x)
    print(y)
    plot_results(axis, x, y, f"Average Power (W) vs Input Size", f"{kernel}", colr, "Input size", "Average Power (Watts)", kernel)
    colr = "red"

plt.savefig(f"power_plot.jpg", bbox_inches='tight')