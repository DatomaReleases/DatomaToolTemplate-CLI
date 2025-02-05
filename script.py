import subprocess

def datoma_entrypoint(params, utils):
    # Gather parameters
    input_file = params["input_file"][0]
    parameter = params["first_parameter"]
    num_cores = int(utils.get_vcpu())

    # Setting up the bash command for your CLI tool
    bash_command = f"cat {input_file} > /app/results/output.txt && echo {parameter} >> /app/results/output.txt"
    
    try:
        result = subprocess.run(["/bin/bash", "-c", bash_command], text=True, check=True) # Execute the command

        print(f"Command executed successfully with exit code: {result.returncode}")
        print(result.stdout)
        print(result.stderr)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred: {e}")
        print(f"Command output: {e.output}")
        print(f"Command stderr: {e.stderr}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        print(f"Command output: {e.output}")
        print(f"Command stderr: {e.stderr}")
    
    print("task finished")

    
# if __name__ == "__main__":    # test purposes 
#     datoma_entrypoint(None, None)