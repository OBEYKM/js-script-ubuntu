server {

    # Default root project
    # root /var/www/site.exemplo.com/html;

    # laravel project test, ou descomente esta linha para o seu projecto principal
     root /var/www/site.exemplo.com/Projecto/public;

    index index.php index.html index.htm index.nginx-debian.html;

    # Colocar aqui o dominio ou ip do servidor
    server_name site.exemplo.com www.site.exemplo.com;

    location / {
        # try_files $uri $uri/ =404;
        try_files $uri $uri/ /index.php?$query_string;
    }

    #location ~ \.php$ {
    #    include snippets/fastcgi-php.conf;
    #   fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    #}
    location ~ \.php$ {
                try_files $uri =404;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }

    location ~ /\.ht {
        deny all;
    }
}


}
