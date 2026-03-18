# 1. Sử dụng Node.js 20-alpine để nhẹ và bảo mật 
FROM node:20-alpine

# Thiết lập biến môi trường để Node biết đây là môi trường production
ENV NODE_ENV=production

# 2. Tạo thư mục làm việc và cấp quyền cho user 'node'
WORKDIR /usr/src/app

# 3. Chép file quản lý thư viện
COPY package*.json ./

# 4. Cài đặt dependencies cho production (nhanh và sạch hơn npm install)
RUN npm ci --only=production

# 5. Chép mã nguồn (Sẽ kết hợp với .dockerignore để bỏ qua node_modules local)
COPY --chown=node:node . .

# 6. Tạo thư mục uploads và đảm bảo user 'node' có quyền ghi [cite: 304, 388]
RUN mkdir -p public/uploads && chown -R node:node public/uploads

# 7. Sử dụng user 'node' thay vì root để tăng tính bảo mật 
USER node

# 8. Mở cổng 3000
EXPOSE 3000

# 9. Lệnh chạy ứng dụng
CMD ["node", "main.js"]