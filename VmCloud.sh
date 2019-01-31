#!/bin/bash

# Functions
add()
{
  echo "---------- addAction ----------"
  if [ $# -lt 1  ];
  then
    echo "Error!" 1>&2
    exit 1
  fi
  local newVmName=$1
  # OS-type selection
  baseVm=$(VBoxManage list vms | awk '{match($1,/^"(.*)"$/, names); print names[1]}' )
  echo $baseVm
  vdi=$(VBoxManage showvminfo Debian9 --machinereadable | grep vdi | awk '{match($1,/("\/(.*)"$)/, names); print names[1]}' | tr -d "\"")
  echo $vdi
  osdesc=$(VBoxManage showvminfo Debian9 --machinereadable | grep ostype | awk '{match($0,/("(.*)"$)/, names); print names[1]}' | tr -d "\"")
  ostype=$(VBoxManage list ostypes | grep "Debian (64-bit)" -B 2 | grep ID | sed 's/.\{13\}//')
  echo $ostype

  #ids=$(VBoxManage list ostypes | grep -e "^ID:" | sed 's/.\{13\}//')
  #baseVm=$(echo $baseVm | sed -e 's/\n//')

  osType=$(zenity --list --title="VM Clone" --column="Type" --text="Base VM Selection" $baseVm)

  if [ -z $ostype ]
  then
    echo "Select a Type!!" 1>&2
    exit 1
  fi

  vmName=$(zenity --forms \
          --title="Ajout de VM" \
          --text="Choix du nom" \
          --add-entry="VM Name" \
          2>/dev/null)
  if [ -z $vmName ]
  then
    echo "Chose a VM name!!" 1>&2
    exit 1
  fi
  VBoxManage createvm --name $vmName --ostype $ostype --register
}

delete()
{
  echo "deleteAction"
}

deploy()
{
  echo "deployAction"
}

list()
{
  echo "listAction"
  for option in $@;
  do
      if [ "$option" = "state" ];
    then
      echo "state"
    fi
    if [ "$option" = "host" ];
    then
      echo "host"
    fi
    # TODO: Else satement
    #

  done
}

powerOn()
{
  $vmName=$1
  echo "$vmName on"
}

powerOff()
{
  $vmName=$1
  echo "$vmName off"
}

powerPause()
{
  $vmName=$1
  echo "$vmName pause"
}

changeState()
{
  echo "changeState"
  if [ $# -ne 2  ];
  then
    echo "Error!" 1>&2
    exit 64
  fi
  local vmName=$1
  local status=$2
  # TODO: Verify if vm exist
  #

  case "$status" in
  "on")
      powerOn "$vmName"
      ;;
  "off")
      powerOff "$vmName"
      ;;
  "pause")
      powerPause "$vmName"
      ;;
  esac
}

makeSnapshot()
{
  $vmName=$1
  echo "$vmName makeSnapshot"
}

restoreSnapshot()
{
  $vmName=$1
  echo "$vmName restoreSnapshot"debian9newnew
}

snapshot()
{
  echo "snapshotAction"
  if [ $# -ne 2  ];
  then
    echo "Error!" 1>&2
    exit 64
  fi
  local vmName=$1
  local action=$2
  # TODO: Verify if vm exist
  #

  case "$action" in
  "make")
      makeSnapshot "$vmName"
      ;;
  "restore")
      restoreSnapshot "$vmName"
      ;;
  esac
}

modify()
{
  echo $sshConnectionString
  echo "modifytAction"
  if [ $# -ne 3  ];
  then
    echo "Error!" 1>&2
    exit 64
  fi
  local vmName=$1
  local key=$2
  local value=$3

  # TODO: Verify if vm exist
  #

  # TODO: Make command
  #

}

# Main
username="c18015030"
ip="10.203.9.116"
sshConnectionString="ssh $username@$ip"

add Test
