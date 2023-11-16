#!/usr/bin/env python3

import os
import sys
import argparse
import subprocess
import shlex
import signal
import tempfile
import textwrap
import json


def get_command_output(command):
    return subprocess.check_output(shlex.split(command)).decode()


def run_script(script):
    import time
    with tempfile.NamedTemporaryFile("w", delete=True) as script_file:
        script_file.write(script)
        script_file.flush()
        process = subprocess.Popen(["bash", script_file.name])

        def signal_handler(_sig, _frame):
            process.kill()

        signal.signal(signal.SIGINT, signal_handler)
        process.wait()


def load_config(filename):
    if not os.path.exists(filename):
        config = {
            "brightness": 1.0,
        }
        return config

    with open(filename, "r", encoding="utf-8") as f:
        config = json.loads(f.read())
    return config


def save_config(filename, config):
    with open(filename, "w") as f:
        f.write(json.dumps(config))


def task_adjust(args):
    config = load_config(args.config)

    brightness = max(0.2, min(1.0, config["brightness"] + float(args.increment)))
    script = f"""
    xrandr --output {args.output} --brightness {brightness}
    """
    run_script(textwrap.dedent(script))

    config["brightness"] = brightness
    save_config(args.config, config)


def process(args):
    match args.command:
        case "adjust-brightness":
            task_adjust(args)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Screen Brightness Auto-pilot")
    parser.add_argument("--config", default="/tmp/brightness-auto-pilot.json")
    parser.add_argument("--output", required=True)

    subparsers = parser.add_subparsers(dest="command")

    ## Command: adjust-brightness 
    parser_adjust = subparsers.add_parser("adjust-brightness")
    parser_adjust.add_argument("increment")

    args = parser.parse_args()
    process(args)
