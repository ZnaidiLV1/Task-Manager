from rest_framework.response import Response
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView

from .serializers import *
from rest_framework.decorators import api_view


@api_view(['POST'])
def create_user(request):
    if request.method == 'POST':
        serializer = user_serializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response("user crreated successufully")
        return Response(serializer.errors, status=400)

@api_view(['POST'])
def logout(request):
    try:
        refresh_token = request.data["refresh"]
        token = RefreshToken(refresh_token)
        token.blacklist()
        return Response({"message": "Successfully logged out."})
    except Exception as e:
        return Response({"error": str(e)})

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        # Add custom claims
        token['email'] = user.email
        token['first_name']=user.first_name
        token['last_name'] = user.last_name
        # ...

        return token


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
