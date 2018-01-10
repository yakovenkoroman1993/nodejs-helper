# nodejs-helper

Note! It needs to add nodejs in common environment. Also, install docker engine and git (for windows) is required.

```sh
nodejs 
# Output v9.3.0

nodejs -v 6
# Output v6.12.3

nodejs -v 6 -c "cd /app; npm i && npm start"
nodejs -v 8 -c "cd /app; npm i && npm start"
nodejs -v 8 -c "cd /app; npm i && npm start" -p "80:3000"
```
