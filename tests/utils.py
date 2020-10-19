from docker import APIClient


def run_command_in_container(container_image, command):
    client = APIClient()

    # Create the container
    container = client.create_container(
        image=container_image,
        command=(
            '/bin/sh -c "sleep {time}; exit {exit}"'.format(
                time=60,
                exit=42,
            )
        ),
        detach=True,
        user='docs',
    )

    # Start the container
    container_id = container.get('Id')
    client.start(container=container_id)

    # Execute commands to verify versions
    exec_cmd = client.exec_create(
        container=container_id,
        cmd=f"/bin/sh -c '{command}'",
        stdout=True,
        stderr=True,
    )
    cmd_output = client.exec_start(exec_id=exec_cmd['Id'], stream=False)
    cmd_output = cmd_output.decode('utf-8', 'replace').strip()

    # Kill container
    client.kill(container_id)

    return cmd_output
