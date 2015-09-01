Doorkeeper::OpenidConnect.configure do
  jws_private_key <<eol
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAquWk11TsSuEGbcezLi2MkmCYAL7euLQ4aYHS+9kZ5zUTfmRJ
MHnBKy9ZQyIQuXI9dPLn42/YTObtrqf+3a2FiUdPedk9CrNjKgSgTmKUf0G9VR85
UmMHfkE5z18934vK+I6R5YyMvDs9n9HAQBRVyuFIuPKhVyJDtewWHhBJ2Ux1hukf
7t8puo05ZyqSOqpt/2t7+mABRfzhRtbI0lscsyIkUmdnV8Vm9RaDv2R0SjaJykH1
D456QayA+HyIeE6+dccmKSLKKp9L4dhFyJsK46K3CvSD4WvuLH3dNZS6SJtxhC6e
CHXv3yj0+eNM8qwCZGV5ozcMQ+7jL2oZD9rwtQIDAQABAoIBAHoYU2rca20b06H+
+M7XEAVMKYzu0OSZLWyDqh7wfocm7mRwdbHCavXVgCpsXhJ/wdSZ7n4ZXCmlGs6b
i4UJAcyQPAHL6MaKXyCX6YfW+kzoxMHZ6vQneCUFqK21V9ksYLiv8yBTCAE7Oc3C
511gqeKmjXRFNGuyOTnyD+Mus/Qgdy0OMlZ4gnzRWt4D/bSxzrSLDVrVtudjpSlX
DG3Qc5V7a6VCEU6XiA0ut3mrSIBQGvbMn4SAZ9w2AD0sYx6gxA3xNPPr9Ww/QYdq
Ev07xIX+8txAL7fDXXmkdcC8+UTCDAe936U+KTd3V/MzysEZpPvCypiOn7xlPQR8
Ia/jd4kCgYEA1czpmO+2QW1TNwUoCgKVuBazIOPLYjpvAIRZuNh/rYzAGvOzHnCX
QVfXHQO1LY1JSRFMAt5wtIrvlnrpFOBliaYMUv/q/J234Wfcs1Mxwwbi8gak/W4n
yAXUn1R2+mI3tlIseIyuaxJvnBHXoelE6nzn2ubbjBrQHoNvdNhvWy8CgYEAzKDf
dUzZOsQzWgI5qwWCUNAS65hia4NjYaVCDukcXqNuM3zrVu3YlnW5aSiat7ApiqY4
aE5QMReqtOnUUQh827hKA6E8Y2cnDE+wLECweBZKyC5y0tqFEEO3QLdGWfF1pkGD
yNjFnRELA2cGSc75g1KDWRrlIJgEl86PbvlFKVsCgYEArLZCJsfOxX/Zb2L8+0kn
RXUg83rRe+KUdSh1intqePpw3dTsZ7Swm5qoLcom/EtcXmhYrSCgj1iFP1y/GZxE
qjO3VP1kCPon5zEN+tdEJbZUcwunEQuBm3YKU0PacV4Sf3hWcHPFGr3j54IKXcOh
ZoPMkOtZhA7M/TlUOmH1YwUCgYB5RxdpdCSDWel9fTgkjl1P/CJak7QxOGvcYY+n
Oq3fwUj9JxpsKQdnFVrQYopgN/5G+IESAOgyUG6STsvRQxCNQMpNIHCkEWzpNQmb
ELQGWF/2COFw6qZWn2uq5XTCtgMeiFHM5f0pPAKk/5iQgiULmgnS88e865w9ROVp
xj8hZQKBgQC4aW0vPhGNxo0BDV1GamnB1pQl7APG+RMCrMrebApBMO7lLrCphWNA
lpTw0TXD128+bjXZJZR7GmoN/SUzqX2KcZ3MB56bu1HoNNdtzd2PVMPsLkt3gkaF
10XlbPCDHNGnEF6YVZsT4wMkMkSOwaBV9O+ix2BRULqmfm41XmycVg==
-----END RSA PRIVATE KEY-----
eol

  jws_public_key <<eol
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAquWk11TsSuEGbcezLi2M
kmCYAL7euLQ4aYHS+9kZ5zUTfmRJMHnBKy9ZQyIQuXI9dPLn42/YTObtrqf+3a2F
iUdPedk9CrNjKgSgTmKUf0G9VR85UmMHfkE5z18934vK+I6R5YyMvDs9n9HAQBRV
yuFIuPKhVyJDtewWHhBJ2Ux1hukf7t8puo05ZyqSOqpt/2t7+mABRfzhRtbI0lsc
syIkUmdnV8Vm9RaDv2R0SjaJykH1D456QayA+HyIeE6+dccmKSLKKp9L4dhFyJsK
46K3CvSD4WvuLH3dNZS6SJtxhC6eCHXv3yj0+eNM8qwCZGV5ozcMQ+7jL2oZD9rw
tQIDAQAB
-----END PUBLIC KEY-----
eol

  resource_owner_from_access_token do |access_token|
    User.find_by(id: access_token.resource_owner_id)
  end

  issuer 'https://sg-openid-connect-example.herokuapp.com'

  subject do |resource_owner|
    "user_#{resource_owner.id}"
  end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  expiration 3600 # FIXME: テスト用。本番では必ず短くすること

  claims do
    normal_claim :name, &:name
    normal_claim :email, &:email
  end
end
