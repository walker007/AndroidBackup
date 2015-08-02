#!/bin/bash


sleep 1
zenity --info \
--title="adb easy backup by: Alex Júnior" \
--window-icon="ico/depuracao.png" \
--text="Primeiramente certifique-se de ter conectado \n o dispositivo no computador com a depuração ativada..."

zenity --info \
--title="adb easy backup by: Alex Júnior" \
--text="Verificando dispositivo"
adb devices

first=$(zenity --entry --text="O que deseja fazer? \n 1) Backup \n 2) Listar Backups \n 3) Recuperar Backup \n") 

case "$first" in

1) 

zenity --info \
--title="adb easy backup by: Alex Júnior" \
--text="Ok! vou preparar as coisas para o backup, aguarde..."
sleep 1
bkp=$(zenity --entry --text="Digite um nome para o backup: \n")
zenity --info \
--title="adb easy backup by: Alex Júnior" \
--text="O nome do seu backup será: "$bkp".ab"
mkdir backup-folder/$bkp
chmod 777 backup-folder/$bkp
sleep 1
mkdir backup-folder/$bkp/pull
chmod 777 backup-folder/$bkp/pull
mkdir backup-folder/$bkp/pull/Download
mkdir backup-folder/$bkp/pull/Android
mkdir backup-folder/$bkp/pull/DCIM
mkdir backup-folder/$bkp/pull/WhatsApp
sleep 1
confirm=$(zenity --entry --text="Deseja realmente Fazer este backup? \n\n 1) Sim \n 2) Não \n\n")
	case "$confirm" in
1)
(
echo "1" ; sleep 1
echo "# Mantenha seu dispositivo sempre conectado no USB" ; sleep 1
echo "5" ; sleep 1
echo "# O backup será salvo na pasta: backup-folder/$bkp" ; sleep 1
echo "10" ; sleep 1
echo "# Estou salvando as pastas principais em: backup-folder/$bkp/pull" ; sleep 1
echo "11" ; sleep 1
echo "# Iniciando..." ; sleep 1
echo "15" ; sleep 1
echo "# Salvando a pasta Download." ; ./adb pull /sdcard/Download backup-folder/$bkp/pull/Download ; sleep 1
echo "20" ; sleep 1
echo "# Salvando a Pasta Android" ; ./adb pull /sdcard/Android backup-folder/$bkp/pull/Android ; sleep 1
echo "25" ; sleep 1
echo "# Salvando a Pasta DCIM" ; ./adb pull /sdcard/DCIM backup-folder/$bkp/pull/DCIM ; sleep 1
echo "30" ; sleep 1
echo "# Salvando a pasta WhatsApp" ; ./adb pull /sdcard/WhatsApp backup-folder/$bkp/pull/WhatsApp ; sleep 1
echo "35" ; sleep 1
echo "# Preparando o backup dos apps" ; sleep 1
echo "40" ; sleep 1
echo "# Entrando na pasta backup-folder/$bkp" 
echo "50" ; sleep 1
echo "# Pronto, agora Desbloqueie seu aparelho e autorize o backup" ;  sleep 1
./adb backup -f backup-folder/$bkp/$bkp".ab" -apk -shared -all -system ; sleep 1
echo "60" ; sleep 1
echo "# Tudo pronto, backup concluido"
echo "100" ; sleep 1
)|
zenity --progress \
  --title="adb easy backup" \
  --text="preparando todos os comandos" \
  --auto-close \
  --no-cancel \
  --auto-kill \
  --percentage=0
;;
2)

(
echo "1" ; sleep 1
echo "# Deixando tudo como estava" ; sleep 2
echo "5" ; sleep 1
echo "# Excluindo comandos adb" ; sleep 1
echo "10" ; sleep 1
echo "# Saindo da pasta criada" ; sleep 1
echo "15" ; sleep 1
echo "# Ajeitando as pastas"
echo "20" ; sleep 1
echo "# Excluindo arquivos de backup" ; sleep 1
echo "25" ; sleep 1
echo "# Excluindo a pasta: $bkp" ; rm -r $bkp ; sleep 1
echo "30" ; sleep 1
echo "# Fixando permissões" ; sleep 1
echo "35" ; sleep 1
echo "# Desconectando ADB" ; sleep 1
echo "40" ; sleep 1
echo "# Verificando dispositivos" ; sleep 1
echo "60" ; sleep 1
echo "# Saindo da pasta backup-folder" ; sleep 1
echo "80" ; sleep 1
echo "# Saindo da aplicação" ; sleep 1
echo "100" ; exit
)|
zenity --progress \
	--title="adb easy backup" \
	--text="Revertendo ações..." \
	--auto-close \
	--no-cancel \
	--auto-kill \
	--percentage=0
esac

;;
2)
touch lis

#find .-xdev -printf'%s %p\n' |sort -nsr|head -20 awk'{print R$6}'
find backup-folder -maxdepth 0 -exec ls '-1Ssh' '{}' '+' |head -n100 >lis
zenity --text-info \
--title="Listando seus backups" \
--filename=lis

rm -f lis
;;
3)
rcv=$(zenity --entry --text="Digite o nome do backup que você quer recuperar:")
zenity --info \ 
--text="Vou recuperar o backup $rcv"

esac
