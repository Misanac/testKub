sudo mkdir /media/sd1
sudo mkdir /media/sd2
sudo mount /dev/mmcblk0p1 /media/sd1
sudo mount /dev/mmcblk0p2 /media/sd2

sudo mkdir /media/ssd1
sudo mkdir /media/ssd2
sudo mount /dev/sda1 /media/ssd1
sudo mount /dev/sda2 /media/ssd2

echo "directorys crated"

sed -i 's/\bmmcblk0p2\b/sda2/g' /media/sd1/cmdline.txt
sed -i 's/\bmmcblk0p2\b/sda2/g' /media/sd2/boot/firmware/cmdline.txt

sed -i 's/\bmmcblk0p2\b/sda2/g' /media/ssd1/cmdline.txt
sed -i 's/\bmmcblk0p2\b/sda2/g' /media/ssd2/boot/firmware/cmdline.txt

echo  "program_usb_boot_mode=1" >> /media/sd1/config.txt 
echo "program_usb_boot_mode=1" >> /media/sd2/boot/firmware/config.txt 

echo  "program_usb_boot_mode=1" >> /media/ssd1/config.txt 
echo "program_usb_boot_mode=1" >> /media/ssd2/boot/firmware/config.txt 

echo "cmdline.txt and config.txt changed in 4 location"

sudo umount /media/sd1
sudo umount /media/sd2
sudo umount /media/ssd1
sudo umount /media/ssd2

echo "directories unmounted"

sudo rmdir /media/sd1
sudo rmdir /media/sd2
sudo rmdir /media/ssd1
sudo rmdir /media/ssd2

echo "dirs deleted"
