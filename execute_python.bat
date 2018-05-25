conda remove --name menpo --all
conda create --name menpo --file spec-file.txt
echo 'Starting script...' > logfile.log
call activate menpo > logfile.log
echo 'Environment Activated...' > logfile.log
python gui.py > logfile.log
echo 'Python Script Run...' > logfile.log
call deactivate > logfile.log
echo 'Environment Deactivated.' > logfile.log
echo 'Preparing for application launch...' > logfile.log
start App\Customiser.exe