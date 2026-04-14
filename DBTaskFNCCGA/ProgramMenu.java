import java.util.Scanner;

public class ProgramMenu {
    private static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        DbMethods.Register();
        boolean running = true;

        while (running) {
            System.out.println("\n--- AUTÓSZERVIZ NYILVÁNTARTÁS ---");
            System.out.println("1 - Ügyfelek listázása");
            System.out.println("2 - Járművek és tulajdonosaik (JOIN)");
            System.out.println("3 - Új ügyfél felvétele");
            System.out.println("4 - Ügyfél lakcím módosítása");
            System.out.println("5 - Ügyfél törlése");
            System.out.println("6 - Teljes szerviz történet (JOIN)");
            System.out.println("0 - Kilépés");
            System.out.print("Választás: ");

            String choice = sc.nextLine();
            switch (choice) {
                case "1": ListingMethods.listAllUgyfel(); break;
                case "2": ListingMethods.listJarmuWithTulajdonos(); break;
                case "3":
                    System.out.print("Név: "); String nev = sc.nextLine();
                    System.out.print("Tel: "); String tel = sc.nextLine();
                    System.out.print("Cím: "); String cim = sc.nextLine();
                    System.out.print("Dátum (YYYY-MM-DD): "); String dat = sc.nextLine();
                    DbMethods.insertUgyfel(nev, tel, cim, dat);
                    break;
                case "4":
                    System.out.print("Módosítandó ID: "); int mId = Integer.parseInt(sc.nextLine());
                    System.out.print("Új cím: "); String uCim = sc.nextLine();
                    DbMethods.updateUgyfelCim(mId, uCim);
                    break;
                case "5":
                    System.out.print("Törlendő ID: "); int tId = Integer.parseInt(sc.nextLine());
                    DbMethods.deleteUgyfel(tId);
                    break;
                case "6":
                    ListingMethods.listTeljesSzervizTortenet();
                    break;
                case "0": running = false; break;
                default: System.out.println("Hibás opció!");
            }
        }
        System.out.println("Program bezárva.");
    }
}