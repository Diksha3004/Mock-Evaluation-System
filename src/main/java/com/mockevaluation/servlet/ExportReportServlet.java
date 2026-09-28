
package com.mockevaluation.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Chunk;

import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import com.mockevaluation.dao.EvaluationDAO;
import com.mockevaluation.dao.ParticipantDAO;

public class ExportReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=MockEvaluationReport.pdf");

        try {

            Document document = new Document();

            PdfWriter.getInstance(
                    document,
                    response.getOutputStream());

            document.open();
            
            

            Font titleFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA_BOLD,
                            22);

            Font headingFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA_BOLD,
                            14);

            Font normalFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA,
                            12);

            Paragraph title =
                    new Paragraph(
                            "MOCK EVALUATION SYSTEM REPORT",
                            titleFont);

            title.setAlignment(
                    Element.ALIGN_CENTER);

            document.add(title);

            document.add(new Paragraph(" "));

            Paragraph date =
                    new Paragraph(
                            "Generated On : "
                                    + new Date(),
                            normalFont);

            date.setAlignment(
                    Element.ALIGN_RIGHT);

            document.add(date);

            document.add(new Paragraph(" "));
            document.add(new Chunk(
                    "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  = = = = = = = = = = =  = = = "));
            document.add(new Paragraph(" "));

            ParticipantDAO participantDAO =
                    new ParticipantDAO();

            EvaluationDAO evaluationDAO =
                    new EvaluationDAO();

            Paragraph summaryHeading =
                    new Paragraph(
                            "SUMMARY REPORT",
                            headingFont);

            document.add(summaryHeading);
            document.add(new Paragraph(" "));

            PdfPTable summaryTable =
                    new PdfPTable(3);

            summaryTable.setWidthPercentage(100);

            summaryTable.addCell(
                    "Total Participants");

            summaryTable.addCell(
                    "Total Evaluations");

            summaryTable.addCell(
                    "Average Score");

            summaryTable.addCell(
                    String.valueOf(
                            participantDAO.getTotalParticipants()));

            summaryTable.addCell(
                    String.valueOf(
                            evaluationDAO.getTotalEvaluations()));

            summaryTable.addCell(
                    String.format(
                            "%.2f",
                            evaluationDAO.getAverageScore()));

            document.add(summaryTable);

            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));

            Paragraph detailHeading =
                    new Paragraph(
                            "EVALUATION DETAILS",
                            headingFont);

            document.add(detailHeading);

            document.add(new Paragraph(" "));

            ArrayList<String[]> report =
                    evaluationDAO.getEvaluationReport();

            PdfPTable detailTable =
                    new PdfPTable(5);

            detailTable.setWidthPercentage(100);

            detailTable.addCell("ID");
            detailTable.addCell("Participant");
            detailTable.addCell("Evaluator");
            detailTable.addCell("Round");
            detailTable.addCell("Score");

            for(String[] row : report){

                detailTable.addCell(row[0]);
                detailTable.addCell(row[1]);
                detailTable.addCell(row[2]);
                detailTable.addCell(row[3]);
                detailTable.addCell(row[4]);
            }

            document.add(detailTable);

            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));

            Paragraph footer =
                    new Paragraph(
                            "Generated By Mock Evaluation System",
                            normalFont);

            footer.setAlignment(
                    Element.ALIGN_CENTER);

            document.add(footer);

            document.close();

        }
        catch(Exception e){

            e.printStackTrace();
        }
    }
}

