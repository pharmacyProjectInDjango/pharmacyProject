from django.urls import path

from mainapp.api.api_views import CategoryListAPIView, ProductsListAPIView, ProductsRetrieveAPIView, \
    CategoryRetrieveAPIView

urlpatterns = [
    path('categories/', CategoryListAPIView.as_view(),name='categories'),
    path('categories/<str:id>',CategoryRetrieveAPIView.as_view(),name='categories_id'),

    path('products/',ProductsListAPIView.as_view(),name='products'),
    path('products/<str:id>',ProductsRetrieveAPIView.as_view(),name='products_id'),


]