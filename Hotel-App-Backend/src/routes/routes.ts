import express, { Request, Response } from "express";
import { User } from "../models/user_model";

const router = express.Router();

//Post request

router.post("/add", async (req: Request, res: Response) => {
  const {  name, email, birthDay, phoneNumber, nationality, gender, address } = req.body;

  const dataItem = User.set({ name, email, birthDay, phoneNumber, nationality, gender, address});

  await dataItem.save();

  return res.status(200).json({
    data: dataItem,
  });
});

//Get request

router.get("/", async (req: Request, res: Response) => {
  try {
    const dataItem = await User.find({});

    res.status(200).json({
      data: dataItem,
    });
  } catch (error) {
    console.log(error);
  }
});

//Delete Request

router.delete("/delete", async (req: Request, res: Response) => {
  const filter = {
    email: req.body.email,
  };

  const dataItem = await User.deleteOne(filter)
    .then((data) =>
      res.json({
        data: data,
      })
    )
    .catch((error) => {
      return res.send(error);
    });
});

//Update request
router.put("/update", async (req: Request, res: Response) => {
  const filter = {
    email: req.body.email,
  };

  const updatedData = {
    title: req.body.title,
    description: req.body.description,
  };

  const dataItem = await User.updateOne(filter, updatedData, {
    new: true,
  })
    .then((data) =>
      res.json({
        data: data,
      })
    )
    .catch((error) => {
      return res.send(error);
    });
});

export { router };