def main():
    p = Popen("execute_python.bat")
    stdout, stderr = p.communicate()