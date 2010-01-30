set makeprg=curl\ -s\ -F\ laxtype=yes\ -F\ parser=html5\ \ -F\ level=error\ -F\ out=gnu\ -F\ doc=@%\ http://validator.nu\ \\\|\ sed\ 's,^.*\":,'\"$1:\"','
set errorformat=\"%f\":%l.%c-%m
