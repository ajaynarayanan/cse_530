from time import sleep
from constants import (
    ASSOCIATIVITY_CONFIG_PARAM_PATTERN,
    CACHE_SIZE_CONFIG_PARAM_PATTERN,
    LOGS_ROOT_DIR,
)
from utils import clear_logs, change_param, run_cacti, read_results


def vary_cache_size(
    cache_size_values=[64000, 128000, 256000, 512000, 1024000, 2048000],
    associativity_value=8,
    experiment_name="area",
    metric="Data array: Area (mm2):",
):
    """
    Impact of increasing cache size on the given metric with fixed associativity
    """
    # set associativity to 8
    change_param(
        config_pattern=ASSOCIATIVITY_CONFIG_PARAM_PATTERN,
        config_value=associativity_value,
    )
    results = []
    for cache_size in cache_size_values:
        # construct log file name
        log_file_path = f"{LOGS_ROOT_DIR}/{experiment_name}/cache_size_{cache_size}.log"
        # change parameter value in config
        change_param(
            config_pattern=CACHE_SIZE_CONFIG_PARAM_PATTERN, config_value=cache_size
        )
        # call cacti
        run_cacti(path_to_log_file=log_file_path)
        # read parameter value
        content = read_results(log_file_path, metric)
        final_value = float(content) if content != "" else -1.0
        results.append(final_value)
    return (cache_size_values, results)


def vary_cache_associativity(
    associativity_values=[1, 2, 4, 8, 16, 32],
    cache_size_bytes=256000,
    experiment_name="area",
    metric="Data array: Area (mm2):",
):
    """
    Impact of increasing associativity on the given metric with fixed cache size
    """
    # set cache size to 256KB
    change_param(
        config_pattern=CACHE_SIZE_CONFIG_PARAM_PATTERN, config_value=cache_size_bytes
    )
    results = []
    for associativity in associativity_values:
        # construct log file name
        log_file_path = (
            f"{LOGS_ROOT_DIR}/{experiment_name}/associativity_{associativity}.log"
        )
        # change parameter value in config
        change_param(
            config_pattern=ASSOCIATIVITY_CONFIG_PARAM_PATTERN,
            config_value=associativity,
        )
        # call cacti
        run_cacti(path_to_log_file=log_file_path)
        # read parameter value
        content = read_results(log_file_path, metric)
        final_value = float(content) if content != "" else -1.0
        results.append(final_value)

    return (associativity_values, results)


if __name__ == "__main__":
    clear_logs()
    print("Running experiment 1 A : Area (mm2) vs Cache size (bytes)")
    x, y = vary_cache_size(
        cache_size_values=[64000, 128000, 256000, 512000, 1024000, 2048000],
        associativity_value=8,
        experiment_name="area",
        metric="Data array: Area (mm2):",
    )
    print(x, y)
    print("Running experiment 1 B : Area (mm2) vs Associativity")
    x, y = vary_cache_associativity(
        associativity_values=[1, 2, 4, 8, 16, 32],
        cache_size_bytes=256000,
        experiment_name="area",
        metric="Data array: Area (mm2):",
    )
    print(x, y)
    print("Running experiment 2 A : Energy (nJ) vs Cache size (bytes)")
    x, y = vary_cache_size(
        cache_size_values=[64000, 128000, 256000, 512000, 1024000, 2048000],
        associativity_value=8,
        experiment_name="energy",
        metric="Data array: Total dynamic read energy/access  (nJ):",
    )
    print(x, y)
    print("Running experiment 2 B : Energy (nJ) vs Associativity")
    x, y = vary_cache_associativity(
        associativity_values=[1, 2, 4, 8, 16, 32],
        cache_size_bytes=256000,
        experiment_name="energy",
        metric="Data array: Total dynamic read energy/access  (nJ):",
    )
    print(x, y)
    print("Running experiment 3 A : Access time (ns) vs Associativity")
    x, y = vary_cache_associativity(
        associativity_values=[1, 2, 4, 8, 16, 32],
        cache_size_bytes=1000000,
        experiment_name="access_time",
        metric="Access time (ns):",
    )
    print(x, y)
    print("Running experiment 3 B : Access time (ns) vs Cache size (bytes)")
    x, y = vary_cache_size(
        cache_size_values=[64000, 128000, 256000, 512000, 1024000, 2048000],
        associativity_value=8,
        experiment_name="access_time",
        metric="Access time (ns):",
    )
    print(x, y)
