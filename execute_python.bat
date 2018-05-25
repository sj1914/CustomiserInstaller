conda create --name menpo --file spec-file.txt && (
  echo "Creating python environment" > logfile.log
) || (
  echo "Created python environment" > logfile.log
)

echo "Activating environment" > logfile.log
call activate menpo > logfile.log
echo "Launching graphical user interface" > logfile.log
python gui.py > logfile.log
echo "Deactivating environment" > logfile.log
call deactivate > logfile.log
echo "Preparing to launch customiser" > logfile.log
start App\Customiser.exe