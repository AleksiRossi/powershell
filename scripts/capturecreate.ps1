## azure config mode arm
## azure vm deallocate -g Roger -n RogerUbuntu
## azure vm generalize -g Roger -n RogerUbuntu
## azure vm capture Roger RogerUbuntu template -t C:\Users\Aleksi\Documents\hardenedubuntu.json

## azure network nic create testrg testvmnic2 -k default -m testvnet -p AamulehtiIP -l "westeurope"
## azure network nic show roger testvmnic = /subscriptions/ce539918-6a57-4a5e-b8ab-6a35463d6990/resourceGroups/Roger/providers/Microsoft.Network/networkInterfaces/testvmnic 
## azure group deployment create testrg testvm -f C:\Users\Aleksi\Documents\hardenedubuntu.json
