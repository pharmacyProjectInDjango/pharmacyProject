from rest_framework.filters import SearchFilter
from rest_framework.generics import ListAPIView, RetrieveAPIView, ListCreateAPIView , RetrieveUpdateAPIView

from mainapp.api.serializers import CategorySerializer, ProductSerializer
from mainapp.models import Category, Product


class CategoryListAPIView(ListAPIView):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()


class CategoryRetrieveAPIView(RetrieveAPIView, RetrieveUpdateAPIView):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()
    lookup_field = 'id'

class ProductsListAPIView(ListCreateAPIView):
     serializer_class = ProductSerializer
     queryset = Product.objects.all()
     filter_backends = [SearchFilter]
     secrch_fields = ['id','price','title']


class ProductsRetrieveAPIView(RetrieveAPIView,RetrieveUpdateAPIView):
     serializer_class = ProductSerializer
     queryset = Product.objects.all()
     lookup_field = 'id'

