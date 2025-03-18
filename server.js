/**
 * 我的潮汐(My Tides)应用服务器
 * 提供简单的静态文件服务
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// 定义端口
const PORT = 8080;

// 定义MIME类型
const MIME_TYPES = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'text/javascript',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
};

// 创建HTTP服务器
const server = http.createServer((req, res) => {
  console.log(`请求: ${req.url}`);
  
  // 解析URL
  let pathname = url.parse(req.url).pathname;
  
  // 默认加载index.html
  if (pathname === '/') {
    pathname = '/index.html';
  }
  
  // 构建文件路径
  const filePath = path.join(__dirname, pathname);
  
  // 获取文件扩展名
  const extname = path.extname(filePath);
  
  // 设置默认的内容类型
  let contentType = MIME_TYPES[extname] || 'application/octet-stream';
  
  // 读取文件
  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        // 文件不存在
        fs.readFile(path.join(__dirname, '404.html'), (err, content) => {
          res.writeHead(404, { 'Content-Type': 'text/html' });
          res.end(content, 'utf-8');
        });
      } else {
        // 服务器错误
        res.writeHead(500);
        res.end(`服务器错误: ${err.code}`);
      }
    } else {
      // 成功响应
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content, 'utf-8');
    }
  });
});

// 启动服务器
server.listen(PORT, () => {
  console.log(`
=================================================
   我的潮汐 (My Tides) 服务器已启动
=================================================
   访问地址: http://my-tides.localhost:${PORT}
   或者:    http://localhost:${PORT}
=================================================
`);
}); 