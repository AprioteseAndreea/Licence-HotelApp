
import mongoose from "mongoose";

interface UserI {
//   title: string;
//   description: string;
      name: string;
      email: string;
      birthDay: string;
      phoneNumber: string;
      nationality: string;
      gender: string;
      address: string;

}

interface UserDocument extends mongoose.Document {
      name: string;
      email: string;
      birthDay: string;
      phoneNumber: string;
      nationality: string;
      gender: string;
      address: string;
}
// //Delete request
// Future deleteData(String id) async {
//   final Uri restAPIURL =
//       Uri.parse("https://todoflutternodejs.herokuapp.com/delete");

//   http.Response response = await httpClient.delete(restAPIURL,
//       headers: customHeaders, body: jsonEncode(id));

//   return response.body;
// }
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
      },
  birthDay: {
    type: String,
    required: false,
  },
  phoneNumber: {
    type: String,
    required: false,
},
 nationality: {
       type: String,
      required: false,
},
       gender: {
       type: String,
       required: false,
      },
address: {
      type: String,
       required: false,
      }
});

interface userModelInterface extends mongoose.Model<UserDocument> {
  set(x: UserI): UserDocument;
}

userSchema.statics.set = (x: UserI) => {
  return new User(x);
};

const User = mongoose.model<UserDocument, userModelInterface>(
  "User", userSchema
);

User.set({
      name: "some name",
      email: "some email",
      birthDay: "some birthday",
      phoneNumber: "some phnumber",
      nationality: "some nationality",
      gender: "some gender",
      address: "some address"
});

export { User };