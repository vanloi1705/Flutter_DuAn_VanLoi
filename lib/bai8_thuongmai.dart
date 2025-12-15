import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Cần thêm intl vào pubspec.yaml nếu muốn format tiền đẹp, ở đây tôi tự viết hàm format đơn giản để bạn không cần cài thêm.

void main() {
  runApp(const ShopeeCloneApp());
}

// --- 1. Cấu hình App & Theme Shopee ---
class ShopeeCloneApp extends StatelessWidget {
  const ShopeeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopee Fake - Văn Lợi',
      theme: ThemeData(
        // Màu cam đặc trưng của Shopee
        primaryColor: const Color(0xFFEE4D2D),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Màu nền xám nhẹ
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEE4D2D),
          foregroundColor: Colors.white,
        ),
      ),
      home: const ShopeeHomeScreen(),
    );
  }
}

// --- 2. Model Sản phẩm ---
class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      // Lấy thêm rating từ API giả lập cho giống thật
      rating: (json['rating']['rate'] as num).toDouble(),
      reviewCount: json['rating']['count'],
    );
  }
}

// --- 3. Màn hình chính ---
class ShopeeHomeScreen extends StatefulWidget {
  const ShopeeHomeScreen({super.key});

  @override
  State<ShopeeHomeScreen> createState() => _ShopeeHomeScreenState();
}

class _ShopeeHomeScreenState extends State<ShopeeHomeScreen> {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Lỗi tải dữ liệu');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình để xử lý Responsive
    double screenWidth = MediaQuery.of(context).size.width;

    // Tính toán số cột: Web rộng thì 6 cột, tablet 4, mobile 2
    int crossAxisCount = screenWidth > 1200 ? 6 : (screenWidth > 800 ? 4 : 2);
    // Tỉ lệ khung hình thẻ sản phẩm (Web cần thẻ ngắn hơn chút)
    double childAspectRatio = screenWidth > 800 ? 0.75 : 0.7;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70), // AppBar cao hơn chút để chứa Search bar
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEE4D2D), Color(0xFFFF7337)], // Gradient cam
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Row(
            children: [
              // Logo Shopee (Text giả lập)
              const Icon(Icons.shopping_bag_outlined, size: 32),
              const SizedBox(width: 5),
              // Nếu màn hình quá nhỏ thì ẩn chữ Shopee đi
              if (screenWidth > 600)
                const Text(
                  "Shopee",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              const SizedBox(width: 20),

              // Thanh tìm kiếm (Giả lập)
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Săn sale nhận quà Văn Lợi...",
                          style: TextStyle(color: Color(0xFFEE4D2D), fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Giỏ hàng
              Stack(
                children: [
                  const Icon(Icons.shopping_cart, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEE4D2D)),
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: const Text(
                        '3', // Số lượng giả
                        style: TextStyle(
                          color: Color(0xFFEE4D2D),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),

              // --- PHẦN TÀI KHOẢN VĂN LỢI ---
              Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"), // Avatar mẫu
                  ),
                  const SizedBox(width: 8),
                  // Chỉ hiện tên nếu màn hình đủ rộng (Tablet/Web)
                  if (screenWidth > 600)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Văn Lợi", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Thành viên Vàng", style: TextStyle(fontSize: 10, color: Colors.white70)),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                // Phần Banner Quảng cáo (Giả lập banner Shopee)
                SliverToBoxAdapter(
                  child: Container(
                    height: screenWidth > 800 ? 250 : 150, // Web banner cao hơn
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        // Banner mẫu
                        image: NetworkImage("https://cf.shopee.vn/file/vn-50009109-c7a2e1ae720f9704f92f72c9ef1a494a_xxhdpi"), 
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                        children: [
                            Positioned(
                                bottom: 10, left: 10,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.black54,
                                    child: const Text("Siêu Sale Hàng Hiệu - Chào mừng Văn Lợi", style: TextStyle(color: Colors.white))
                                )
                            )
                        ]
                    ),
                  ),
                ),

                // Tiêu đề danh sách: GỢI Ý HÔM NAY
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children: const [
                        Text("GỢI Ý HÔM NAY", style: TextStyle(color: Color(0xFFEE4D2D), fontWeight: FontWeight.bold, fontSize: 16)),
                        Spacer(),
                        Text("Xem tất cả >", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                
                // Khoảng cách nhỏ
                const SliverToBoxAdapter(child: SizedBox(height: 4)),

                // Lưới sản phẩm
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Số cột linh hoạt
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductItem(product: snapshot.data![index]);
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator(color: Color(0xFFEE4D2D)));
        },
      ),
    );
  }
}

// --- 4. Widget Thẻ Sản Phẩm (Thiết kế giống Shopee) ---
class ProductItem extends StatelessWidget {
final Product product;

const ProductItem({super.key, required this.product});

// Hàm chuyển đổi tiền tệ sử dụng thư viện INTL
String formatCurrency(double priceUSD) {
double priceVND = priceUSD * 25000;
final formatter = NumberFormat.currency(
locale: 'vi_VN', // Đảm bảo định dạng Việt Nam
symbol: '₫', 
decimalDigits: 0, // Không lấy số thập phân
);
return formatter.format(priceVND);
}
// ...
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2), // Bo góc rất ít giống Shopee
        border: Border.all(color: Colors.grey[200]!), // Viền mờ
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh sản phẩm
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Image.network(product.image, fit: BoxFit.contain),
                ),
                // Tem "Yêu thích"
                Positioned(
                  top: 4, left: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEE4D2D),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(2), bottomRight: Radius.circular(2)),
                    ),
                    child: const Text("Yêu thích", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
                // Tem "Giảm giá" góc phải
                Positioned(
                  top: 0, right: 0,
                  child: Container(
                    width: 36, height: 42,
                    color: const Color.fromRGBO(255, 212, 36, 0.9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("50%", style: TextStyle(color: Color(0xFFEE4D2D), fontWeight: FontWeight.bold, fontSize: 12)),
                        Text("GIẢM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          
          // 2. Thông tin
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên sản phẩm
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, height: 1.2),
                ),
                const SizedBox(height: 8),
                
                // Thẻ Freeship (Giả lập)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00BFA5)),
                  ),
                  child: const Text("Đang bán chạy", style: TextStyle(color: Color(0xFF00BFA5), fontSize: 9)),
                ),
                const SizedBox(height: 8),

                // Giá tiền & Đã bán
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        formatCurrency(product.price),
                        style: const TextStyle(color: Color(0xFFEE4D2D), fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Đã bán ${product.reviewCount}",
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}