conda env create -f environment.yml
echo 'Starting script...' 
activate menpo >> logfile.log
echo 'Environment Activated...' >> logfile.log
python gui.py >> logfile.log
echo 'Python Script Run...' >> logfile.log
deactivate >> logfile.log
echo 'Environment Deactivated.' >> logfile.log
echo 'Preparing for application launch...' >> logfile.log
start Customiser.exe
exit